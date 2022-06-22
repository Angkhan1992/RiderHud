import 'package:flutter/material.dart';
import 'package:riderhub/screens/auth/login_screen.dart';
import 'package:riderhub/screens/auth/splash_screen.dart';
import 'package:riderhub/screens/main_screen.dart';
import 'package:riderhub/utils/constants.dart';

class RouterService {
  static getRoutes() {
    return <String, WidgetBuilder>{
      Constants.route_splash: (context) => SplashScreen(),
      Constants.route_login: (context) => LoginScreen(),
      Constants.route_main: (context) => MainScreen(),
    };
  }
}