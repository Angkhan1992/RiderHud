import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/order_model.dart';
import 'package:riderhub/services/navigator_service.dart';
import 'package:riderhub/services/network_service.dart';
import 'package:riderhub/services/string_service.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';

class HistoryScreen extends StatefulWidget {
  final bool isEnglish;
  final DateTime dateTime;

  const HistoryScreen({
    Key key,
    this.isEnglish,
    this.dateTime,
  }) : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<OrderModel> histories = [];
  String total_card_amount = '0';
  String total_card_orders = '0';
  String total_cash_amount = '0';
  String total_cash_orders = '0';
  String total_distance = '0';
  var pageValue = 0;

  DateTime selectedDate;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    updateDate(widget.dateTime);
  }

  void updateDate(DateTime dateTime) {
    selectedDate = dateTime;
    Timer.run(() {
      getHistories(true);
    });
  }


  Future getHistories(bool isProgress) async {
    if (isProgress) {
      pageValue = 0;
    }
    var param = {
      'r': 'v1/service',
      'action': 'order_list',
      'params[page]': '$pageValue',
      'params[fromDate]': Constants.isUITestMode? '2020-01-01' :
      StringService.formattedDate('yyyy-MM-dd', selectedDate),
      'params[toDate]': StringService.formattedDate('yyyy-MM-dd', selectedDate),
    };

    var resp = await NetworkService(context)
        .ajax('api.php', param, isPost: false, isProgress: isProgress, isFull: false);
    if (resp['type'] == Constants.response_type_success) {
      if (isProgress) {
        histories.clear();
      }
      for (var jsonOrder in resp['data']['orders']) {
        OrderModel orderModel = OrderModel.fromMap(jsonOrder);
        histories.add(orderModel);
      }
      total_card_amount =
          resp['data']['payment']['total_card_amount'].toString();
      total_card_orders =
          resp['data']['payment']['total_card_orders'].toString();
      total_cash_amount =
          resp['data']['payment']['total_cash_amount'].toString();
      total_cash_orders =
          resp['data']['payment']['total_cash_orders'].toString();
      total_distance = resp['data']['payment']['total_distance'].toString();
    } else {
      NavigatorService(context).showSnackbar(resp['message'], widget.key,
          type: SnackBarType.ERROR);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('[History] amount: ${histories.length}');
    return Column(
      children: [
        SizedBox(
          height: offsetSm,
        ),
        Container(
          height: 60.0,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: offsetXSm),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(!widget.isEnglish ? 0 : offsetSm),
                      bottomRight: Radius.circular(!widget.isEnglish ? 0 : offsetSm),
                      topLeft: Radius.circular(widget.isEnglish ? 0 : offsetSm),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Text(
                        S.of(context).day,
                        style: boldText,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: offsetSm),
                          child: Text(
                            StringService.getDate(selectedDate, 'dd'),
                            style: boldText.copyWith(fontSize: 28.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 1.0,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: offsetXSm),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(offsetSm),
                      bottomRight: Radius.circular(offsetSm),
                      bottomLeft: Radius.circular(offsetSm),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Text(
                        S.of(context).month,
                        style: boldText,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: offsetSm),
                          child: Text(
                            StringService.getDate(selectedDate, 'MM'),
                            style: boldText.copyWith(fontSize: 28.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 1.0,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: offsetXSm),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(!widget.isEnglish ? 0 : offsetSm),
                      topRight: Radius.circular(widget.isEnglish ? 0 : offsetSm),
                      bottomRight: Radius.circular(widget.isEnglish ? 0 : offsetSm),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Text(
                        S.of(context).year,
                        style: boldText,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: offsetSm),
                          child: Text(
                            StringService.getDate(selectedDate, 'yyyy'),
                            style: boldText.copyWith(fontSize: 28.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: offsetBase),
          padding:
          EdgeInsets.only(top: 30.0, left: offsetBase, right: offsetBase),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).today_order,
                          style: boldText.copyWith(
                              fontSize: 17.0, color: Colors.black),
                        ),
                        SizedBox(
                          width: offsetSm,
                        ),
                        Text(
                          '${int.parse(total_cash_orders) + int.parse(total_card_orders)}',
                          style: boldText.copyWith(
                              fontSize: 17.0, color: mainColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: offsetXSm,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_distance.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(
                          width: offsetXSm,
                        ),
                        Text(
                          StringService.distanceFormatted(total_distance) +
                              ' ${S.of(context).distance_unit}',
                          style: boldText.copyWith(
                              fontSize: 12.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/icons/ic_coin.png',
                width: 24.0,
                height: 24.0,
              ),
              SizedBox(
                width: offsetXSm,
              ),
              Text(
                '${StringService.priceFormatted(total_cash_amount)} ${S.of(context).price_unit}',
                style: boldText.copyWith(fontSize: 12.0, color: Colors.black),
              ),
            ],
          ),
        ),
        Expanded(
          child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            onRefresh: null,
            onLoading: () async {
              pageValue++;
              await getHistories(false);
              _refreshController.refreshCompleted();
              _refreshController.loadComplete();
            },
            controller: _refreshController,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var history in histories)
                    history.itemWidget(context, widget.isEnglish),
                  SizedBox(
                    height: offsetMd,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
