import 'package:charts_flutter/flutter.dart' as charts;

class Constants {
  static String keyLanguage = 'key_language';
  static String keyGender = 'key_gender';
  static String keyAlarms = 'key_alarms';
  static String keyToken = 'key_token';
  static String keyDeviceToken = 'key_device_token';
  static String keyEmail = 'key_email';
  static String keyPassword = 'key_password';

  static const route_splash = '/splash';
  static const route_login = '/login';
  static const route_main = '/main';

  static const response_type_success = 'success';

  static const api_service_regional = 'service&action=regional_zones';

  static const status_offline = 1;
  static const status_ready = 2;
  static const status_online = 3;
  static const status_break = 4;
  static const status_overtime = 5;

  static double CAMERA_ZOOM = 16;
  static double CAMERA_TILT = 80;
  static double CAMERA_BEARING = 30;

  // UI Test Data
  static bool isUITestMode = false;

  static List<charts.Series<GaugeSegment, String>> createRandomData() {
    final data = [
      new GaugeSegment('Low', 73, charts.Color(r: 255, b: 0, g: 108)),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }

  static List<String> deliveryOrdersTitle = [
    '2x Chicken Rolls',
    '1x Pizza Cheese',
    '2x Coca-Cola',
    '1x Large Fries',
  ];

  static var notificationData = [
    {
      'title': 'App Update',
      'description':
          'Dear riders,  you need to update the app today to start your duty',
      'timestamp': '07/07/2021      9:45 pm',
    },
    {
      'title': 'Policy & Agreement Update',
      'description':
          'All riders must replace their old T-shirts and follow Tasleem Company uniform',
      'timestamp': '06/07/2021      17:41 pm',
    },
    {
      'title': 'Today’s Contest',
      'description':
          'Any Rider scored 25 Orders Without cancellation will be awarded 15 OMR Bonus',
      'timestamp': '05/07/2021     10:28 am',
    },
  ];
}

class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}
