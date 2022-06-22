import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/services/pref_service.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

const String DOMAIN = 'https://tasleem.in/api.php?r=v1/';

class NetworkService {
  final BuildContext context;

  NetworkService(this.context);

  Future<dynamic> ajax(
    String link,
    Map<String, dynamic> parameter, {
    bool isProgress = false,
    bool isFullUrl = false,
    bool isPost = true,
    bool isFull = true,
    bool isUseToken = true,
  }) async {
    if (isProgress && context != null)
      LoadService().showLoading(context, isFull: isFull);

    var lang = await PrefService().getLanguage();

    var token = await PrefService().getToken();
    if (token.isNotEmpty && isUseToken) {
      parameter['token'] = token;
      parameter['params[token]'] = token;
    }
    print('===== [http] request params ====> \n${parameter.toString()}');

    Uri url;
    if (isFullUrl) {
      if (isPost) {
        url = Uri.parse('$link');
      } else {
        url = Uri.https('addresses.tasleem.in', '/$link', parameter);
      }
    } else {
      if (isPost) {
        url = Uri.parse('$DOMAIN$link');
      } else {
        url = Uri.https('tasleem.in', '/$link', parameter);
      }
    }

    print('===== [http] request link ====> \n${url.toString()}');

    if (isPost) {
      final response = await http.post(
        url,
        body: parameter,
        headers: {
          'Accept-Language': lang,
        },
      ).timeout(Duration(minutes: 3));
      if (isProgress && context != null) LoadService().hideLoading(context);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('===== [http] $link response ====> \n${response.body}');
        var json = jsonDecode(response.body);
        return json;
      } else {
        print('===== [http] $link failed ====>  ${response.statusCode}');
        Exception(response.statusCode);
      }
    } else {
      final response = await http.get(
        url,
        headers: {
          'Accept-Language': lang,
        },
      ).timeout(Duration(minutes: 3));
      if (isProgress && context != null) LoadService().hideLoading(context);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('===== [http] $link response ====> \n${response.body}');
        var json = jsonDecode(response.body);
        return json;
      } else {
        print('===== [http] $link failed ====>  ${response.statusCode}');
        Exception(response.statusCode);
      }
    }
  }
}

bool isShowing = false;

class LoadService {
  bool hideLoading(BuildContext context) {
    if (context == null) {
      return true;
    }
    isShowing = false;
    Navigator.of(context).pop(true);
    return true;
  }

  bool showLoading(BuildContext context, {bool isFull = true}) {
    if (context == null) {
      return true;
    }
    isShowing = true;
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: isFull
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: offsetLg, vertical: offsetMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(offsetBase)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            S.of(context).api_connection_title,
                            style: boldText.copyWith(
                                fontSize: 18.0, color: Colors.black),
                          ),
                          SizedBox(
                            height: offsetBase,
                          ),
                          Text(
                            S.of(context).api_connection_desc,
                            style: boldText.copyWith(color: darkGreyTextColor),
                          ),
                          SizedBox(
                            height: offsetBase,
                          ),
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(mainColor),
                          ),
                        ],
                      ),
                    )
                  : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                    ),
            ),
          );
        },
        useRootNavigator: false);
    return true;
  }

  void showScheduledLoading(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => showLoading(context));
  }
}
