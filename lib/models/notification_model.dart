import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class NotificationModel {
  String title;
  String description;
  String timestamp;

  NotificationModel({
    this.title,
    this.description,
    this.timestamp,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return new NotificationModel(
      title: map['title'] as String,
      description: map['description'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'timestamp': this.timestamp,
    };
  }

  Widget itemWidget({bool isEnglish = true}) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: offsetBase),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: offsetBase,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: boldText.copyWith(fontSize: 15.0, color: Colors.black),
                ),
                SizedBox(
                  height: offsetSm,
                ),
                Text(
                  description,
                  style:
                      mediumText.copyWith(fontSize: 13.0, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            alignment: isEnglish?Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              timestamp,
              style: mediumText.copyWith(fontSize: 10.0, color: Colors.black),
            ),
          ),
          SizedBox(
            height: offsetXSm,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: darkGreyTextColor,
          ),
        ],
      ),
    );
  }
}
