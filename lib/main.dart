import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:riderhub/services/inject_service.dart';
import 'package:riderhub/services/pref_service.dart';
import 'package:riderhub/services/router_service.dart';
import 'package:riderhub/services/socket_service.dart';
import 'package:riderhub/utils/constants.dart';

import 'generated/l10n.dart';

Injector injector;
SocketService socketService;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AppInitializer {
  initialise(Injector injector) async {}
}

Future<void> main() async {
  InjectionService().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  await AppInitializer().initialise(injector);

  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  void initState() {
    super.initState();

    getLocal();
  }

  void getLocal() async {
    String lang = await PrefService().getLanguage();
    setLocale(Locale.fromSubtags(languageCode: lang));
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Constants.route_splash,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: RouterService.getRoutes(),
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
