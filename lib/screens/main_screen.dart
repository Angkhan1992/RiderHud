import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/main.dart';
import 'package:riderhub/screens/main/history_screen.dart';
import 'package:riderhub/screens/main/notification_screen.dart';
import 'package:riderhub/screens/main/order_screen.dart';
import 'package:riderhub/screens/main/status_screen.dart';
import 'package:riderhub/services/location_service.dart';
import 'package:riderhub/services/navigator_service.dart';
import 'package:riderhub/services/network_service.dart';
import 'package:riderhub/services/pref_service.dart';
import 'package:riderhub/services/socket_service.dart';
import 'package:riderhub/themes/colors.dart' as color;
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/utils/params.dart';
import 'package:riderhub/widgets/block_account_widget.dart';
import 'package:riderhub/widgets/draw_widget.dart';

import 'main/chat_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var titles = [];
  var bottomItems = [];
  var statusItems = [];

  var isBlock = true;

  var selectedDate = DateTime.now();

  var selectedIndex = 0;
  var isMenuOpen = false;
  var isNotificationOpen = false;

  var isEnglish = true;
  var statusValue = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<HistoryScreenState> _historyKey =
      new GlobalKey<HistoryScreenState>();

  @override
  void initState() {
    super.initState();

    socketService = injector.get<SocketService>();
    socketService.createSocketConnection();

    Timer.run(() {
      asyncData();
      isBlock = Params.currentUser.is_blocked == '1';
      if (isBlock) {
        showDialog(
            context: context,
            builder: (context) {
              return BlockAccountWidget();
            });
      }
    });
  }

  void asyncData() async {
    isEnglish = await PrefService().getLanguage() == 'en';
    await getDriverSchedule();
  }

  Future getDriverSchedule() async {
    var param = {
      'r': 'v1/service',
      'action': 'driver_schedule',
    };

    var resp =
        await NetworkService(context).ajax('api.php', param, isPost: false);
    if (resp['type'] == Constants.response_type_success) {
      statusValue = resp['data']['driver_status'] - 1;
      print('statusValue ===> $statusValue');
    } else {
      NavigatorService(context).showSnackbar(resp['message'], _scaffoldKey,
          type: SnackBarType.ERROR);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screens = [
      StatusScreen(
        scaffoldKey: _scaffoldKey,
        isEnglish: isEnglish,
        actionNotification: () {
          setState(() {
            isNotificationOpen = true;
          });
        },
      ),
      OrderScreen(
        isEnglish: isEnglish,
      ),
      HistoryScreen(
        key: _historyKey,
        dateTime: selectedDate,
        isEnglish: isEnglish,
      ),
      ChatScreen(isEnglish: isEnglish),
    ];

    bottomItems = [
      {
        'icon_on': 'assets/icons/ic_status_on.png',
        'icon_off': 'assets/icons/ic_status_off.png',
        'title': S.of(context).bottom_status,
      },
      {
        'icon_on': 'assets/icons/ic_order_on.png',
        'icon_off': 'assets/icons/ic_order_off.png',
        'title': S.of(context).bottom_orders,
      },
      {
        'icon_on': 'assets/icons/ic_history_on.png',
        'icon_off': 'assets/icons/ic_history_off.png',
        'title': S.of(context).bottom_history,
      },
      {
        'icon_on': 'assets/icons/ic_chat_on.png',
        'icon_off': 'assets/icons/ic_chat_off.png',
        'title': S.of(context).bottom_chat,
      },
    ];

    titles = [
      S.of(context).title_status,
      S.of(context).title_order,
      S.of(context).title_history,
      S.of(context).title_chat,
    ];

    statusItems = [
      {
        'id': 'OFFLINE',
        'title': S.of(context).title_offline,
        'status': S.of(context).status_offline,
        'color': color.redBadgeColor,
      },
      {
        'id': 'SOON',
        'title': S.of(context).title_soon,
        'status': S.of(context).status_soon,
        'color': color.orangeBadgeColor,
      },
      {
        'id': 'ONLINE',
        'title': S.of(context).title_online,
        'status': S.of(context).status_online,
        'color': color.greenBadgeColor,
      },
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            titles[selectedIndex],
            style:
                boldText.copyWith(fontSize: 18.0, color: color.greyTextColor),
          ),
          centerTitle: false,
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(
              isMenuOpen || isNotificationOpen ? Icons.close : Icons.menu,
              color: isMenuOpen ? Colors.black : color.greyTextColor,
            ),
            onPressed: () {
              setState(() {
                if (isNotificationOpen) {
                  isNotificationOpen = false;
                } else {
                  isMenuOpen = !isMenuOpen;
                }
              });
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: offsetBase),
              child: selectedIndex == 3
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: offsetBase),
                      child: Column(
                        children: [
                          Spacer(),
                          Text(
                            S.of(context).chat_support,
                            style: boldText.copyWith(color: Colors.black),
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  : selectedIndex == 2
                      ? Row(
                          children: [
                            IconButton(
                                icon: Image.asset(
                                  isEnglish
                                      ? 'assets/icons/ic_arrow_left.png'
                                      : 'assets/icons/ic_arrow_right.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedDate = selectedDate
                                        .subtract(Duration(days: 1));
                                    _historyKey.currentState
                                        .updateDate(selectedDate);
                                  });
                                }),
                            IconButton(
                                icon: Image.asset(
                                  isEnglish
                                      ? 'assets/icons/ic_arrow_right.png'
                                      : 'assets/icons/ic_arrow_left.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedDate =
                                        selectedDate.add(Duration(days: 1));
                                    _historyKey.currentState
                                        .updateDate(selectedDate);
                                  });
                                }),
                            IconButton(
                                icon: Image.asset(
                                  'assets/icons/ic_calendar.png',
                                  width: 24.0,
                                  height: 24.0,
                                ),
                                onPressed: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(1970),
                                      lastDate: DateTime.now(),
                                      builder: (context, widget) {
                                        return Theme(
                                            data: ThemeData(
                                                primarySwatch: matMainColor),
                                            child: widget);
                                      });
                                  if (date != null) {
                                    setState(() {
                                      selectedDate = date;
                                      _historyKey.currentState
                                          .updateDate(selectedDate);
                                    });
                                  }
                                }),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: offsetBase),
                          child: Column(
                            children: [
                              Spacer(),
                              Text(
                                statusItems[statusValue]['title'],
                                style: boldText.copyWith(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    statusItems[statusValue]['status'],
                                    style: boldText.copyWith(
                                        fontSize: 12.0,
                                        color: color.greyTextColor),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4.0),
                                    width: 5.0,
                                    height: 5.0,
                                    decoration: BoxDecoration(
                                      color: statusItems[statusValue]['color'],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.0)),
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
            ),
          ],
        ),
        body: isMenuOpen
            ? DrawMenu(
                isEnglish: isEnglish,
                changeLanguage: (lang) async {
                  await PrefService().setLanguage(lang);
                  isEnglish = lang == 'en';
                  MyApp.of(context)
                      .setLocale(Locale.fromSubtags(languageCode: lang));
                  Timer(Duration(milliseconds: 500), () {
                    setState(() {});
                  });
                },
                requestBreak: () => _requestBreak(),
                extendDuty: () => _extendDuty(),
              )
            : isNotificationOpen
                ? NotificationScreen(
                    isEnglish: isEnglish,
                  )
                : screens[selectedIndex],
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            height: kBottomNavigationBarHeight + offsetBase,
            child: Row(
              children: [
                for (var item in bottomItems)
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isMenuOpen = false;
                            isNotificationOpen = false;
                            selectedIndex = bottomItems.indexOf(item);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              selectedIndex == bottomItems.indexOf(item)
                                  ? item['icon_on']
                                  : item['icon_off'],
                              width: 40.0,
                              height: 40.0,
                            ),
                            Text(
                              item['title'],
                              style: boldText.copyWith(
                                  fontSize: 14.0,
                                  color:
                                      selectedIndex == bottomItems.indexOf(item)
                                          ? color.mainColor
                                          : color.greyTextColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _requestBreak() async {
    Position position = await LocationService.determinePosition();
    var param = {
      'action': 'request_break',
      'params[reason]': 'Need to pray',
      'params[latitude]': '${position.latitude}',
      'params[longitude]': '${position.longitude}',
    };
    var resp =
        await NetworkService(context).ajax('service', param, isProgress: true);
    if (resp['type'] == Constants.response_type_success) {
      NavigatorService(context).showSnackbar(resp['message'], _scaffoldKey);
    } else {
      NavigatorService(context).showSnackbar(resp['message'], _scaffoldKey,
          type: SnackBarType.ERROR);
    }
  }

  void _extendDuty() async {
    Position position = await LocationService.determinePosition();
    var param = {
      'action': 'request_extension',
      'params[reason]': 'Need 2 hours extra work',
      'params[latitude]': '${position.latitude}',
      'params[longitude]': '${position.longitude}',
    };
    var resp =
        await NetworkService(context).ajax('service', param, isProgress: true);
    if (resp['type'] == Constants.response_type_success) {
      NavigatorService(context).showSnackbar(resp['message'], _scaffoldKey);
    } else {
      NavigatorService(context).showSnackbar(resp['message'], _scaffoldKey,
          type: SnackBarType.ERROR);
    }
  }
}
