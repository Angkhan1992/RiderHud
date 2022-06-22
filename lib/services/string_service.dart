import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class StringService {
  static String getDate(DateTime dateTime, String format) {
    var formatter = new DateFormat(format);
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static String priceFormatted(String price) {
    if (price == null || price.isEmpty) {
      return '0.000';
    }
    final formatter = new NumberFormat("#0.000");
    return formatter.format(double.parse(price));
  }

  static String distanceFormatted(String distance) {
    if (distance == null || distance.isEmpty) {
      return '0.00';
    }
    final formatter = new NumberFormat("#0.00");
    return formatter.format(double.parse(distance));
  }

  static String orderIdFormatted(String orderid) {
    if (orderid == null || orderid.isEmpty) {
      return '#0000000000';
    }
    final formatter = new NumberFormat("#0000000000");
    return '#' + formatter.format(double.parse(orderid));
  }

  static String orderNumberFormatted(String orderNumber) {
    if (orderNumber == null || orderNumber.isEmpty) {
      return '000#';
    }
    final formatter = new NumberFormat("#000");
    return formatter.format(double.parse(orderNumber)) + '#';
  }

  static String timestampToTime(String timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    var format = new DateFormat('HH:mm a');
    return format.format(date);
  }

  static String formattedDate(String formatStr, DateTime date) {
    var format = new DateFormat(formatStr, Locale('en').languageCode);
    return format.format(date);
  }
}

