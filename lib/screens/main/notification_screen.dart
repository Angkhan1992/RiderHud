import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/notification_model.dart';
import 'package:riderhub/themes/colors.dart' as color;
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  final bool isEnglish;

  const NotificationScreen({Key key, this.isEnglish}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      _getNotifications();
    });
  }

  void _getNotifications() async {
    notifications.clear();
    if (Constants.isUITestMode) {
      for (var json in Constants.notificationData) {
        var model = NotificationModel.fromMap(json);
        notifications.add(model);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 2,
          color: color.dividerColor,
        ),
        Container(
          width: double.infinity,
          height: 44.0,
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(
            S.of(context).notifications,
            style: mediumText.copyWith(color: color.redTextColor),
          ),
        ),
        Container(
          width: double.infinity,
          height: 2,
          color: color.dividerColor,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var model in notifications)
                  model.itemWidget(isEnglish: widget.isEnglish),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
