import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riderhub/models/region_model.dart';
import 'package:riderhub/models/user_model.dart';
import 'package:riderhub/services/network_service.dart';
import 'package:riderhub/services/pref_service.dart';
import 'package:riderhub/themes/colors.dart' as color;
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/utils/params.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      checkData();
    });
  }

  void checkData() async {
    var respRegion =
        await NetworkService(context).ajax(Constants.api_service_regional, {});
    if (respRegion['type'] == Constants.response_type_success) {
      var jsonArray = respRegion['data']['regional_zones'];
      Params.regionModels.clear();
      for (var json in jsonArray) {
        RegionModel model = RegionModel.fromMap(json);
        Params.regionModels.add(model);
      }
    }

    var token = await PrefService().getToken();
    if (token.isNotEmpty) {
      var param = {
        'r': 'v1/login_v3',
        'params[user_type]': '0',
        'deviceToken': 'deviceToken',
        'devicePlatform': Platform.isAndroid ? 'android' : 'iOS',
      };
      var resp = await NetworkService(context).ajax(
          'api.php', param, isPost: false);
      if (resp['type'] == Constants.response_type_success) {
        Params.currentUser = UserModel.fromMap(resp['data']['info']);

        String token = resp['data']['info']['token'] as String;
        await PrefService().setToken(token);

        Navigator.of(context).pushReplacementNamed(
            Constants.route_main,
            arguments: 0);
        return;
      }
    }

    Navigator.of(context)
        .pushReplacementNamed(Constants.route_login, arguments: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.mainColor,
      body: Center(
        child: Image.asset(
          'assets/images/app_logo.png',
          width: 250.0,
          height: 250.0,
        ),
      ),
    );
  }
}
