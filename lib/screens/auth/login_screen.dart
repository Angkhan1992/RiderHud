import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/region_model.dart';
import 'package:riderhub/models/user_model.dart';
import 'package:riderhub/services/navigator_service.dart';
import 'package:riderhub/services/network_service.dart';
import 'package:riderhub/services/pref_service.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/utils/params.dart';
import 'package:riderhub/widgets/login/login_button_widget.dart';
import 'package:riderhub/widgets/login/login_text_field.dart';
import 'package:riderhub/themes/dimens.dart' as dimen;
import 'package:riderhub/screens/auth/select_region_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var numberController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var dropDownValue = '';
  var selectedRegion = RegionModel();
  var lang = '';

  var isValid = false;

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      lang = await PrefService().getLanguage();
      setState(() {
        dropDownValue = S.of(context).region_picker_title;
      });
    });

    numberController.addListener(() => validTextField());
    passwordController.addListener(() => validTextField());
  }

  void validTextField() {
    String number = numberController.text;
    String password = passwordController.text;
    setState(() {
      print('selectedRegion ===> ${selectedRegion.toJson()}');
      isValid = number.isNotEmpty && password.isNotEmpty & (selectedRegion.id != null);
    });
  }

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: ExactAssetImage('assets/images/bg_login.png'),
        fit: BoxFit.cover,
      )),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            brightness: Brightness.dark,
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 125,
                  height: 125,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/app_logo.png',
                        width: 125.0,
                        height: 125.0,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          S.of(context).app_title,
                          style: boldText.copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
                LoginTextField(
                  margin: EdgeInsets.only(
                      left: dimen.offsetXLg, right: dimen.offsetXLg, top: 64.0),
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  hint: S.of(context).rhid_number,
                ),
                LoginTextField(
                  margin: EdgeInsets.only(
                      left: dimen.offsetXLg, right: dimen.offsetXLg, top: 16.0),
                  controller: passwordController,
                  isPassword: true,
                  hint: S.of(context).password,
                ),
                Container(
                  width: double.infinity,
                  height: 48.0,
                  margin: EdgeInsets.only(
                      left: dimen.offsetXLg, right: dimen.offsetXLg, top: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: dimen.offsetXMd),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.29),
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  child: InkWell(
                    onTap: () => NavigatorService(context)
                        .pushToWidget(screen: SelectRegionScreen(), pop: (region) {
                          if (region != null) {
                            dropDownValue = lang == 'en'? region.title : region.title_ar;
                            selectedRegion = region;
                            validTextField();
                          }
                    }),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            dropDownValue,
                            style: boldText.copyWith(color: Colors.white),
                            maxLines: 1,
                          ),
                        ),
                        Image.asset(
                          'assets/icons/ic_drop_down.png',
                          width: 20.0,
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                LoginButtonWidget(
                  margin: EdgeInsets.only(
                      left: 130.0, right: 130.0, top: 48.0, bottom: 20.0),
                  title: S.of(context).login,
                  onPressed: isValid? () => _login() : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String number = numberController.text;
    String password = passwordController.text;
    String regionid = selectedRegion.id;

    var param = {
      'r' : 'v1/login_v3',
      'params[rhid]' : '$number',
      'params[password]' : '$password',
      'params[user_type]' : '0',
      'params[regional_zone_id]' : '$regionid',
    };

    var resp = await NetworkService(context).ajax('api.php', param, isPost: false, isProgress: true);
    if (resp['type'] == Constants.response_type_success) {
      Params.currentUser = UserModel.fromMap(resp['data']['info']);

      String token = resp['data']['info']['token'] as String;
      await PrefService().setToken(token);

      Navigator.of(context).pushReplacementNamed(
          Constants.route_main,
          arguments: 0);
    } else {
      NavigatorService(context).showSnackbar(resp['message'], _scaffoldKey,
          type: SnackBarType.ERROR);
    }
  }
}
