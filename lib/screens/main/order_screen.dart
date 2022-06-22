import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/order_model.dart';
import 'package:riderhub/services/network_service.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/utils/params.dart';

class OrderScreen extends StatefulWidget {
  final bool isEnglish;
  const OrderScreen({Key key, this.isEnglish}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel> assignedOrders = [];
  List<OrderModel> pendingOrders = [];

  var zoneName = '';

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      getLocationData();
      getOrders(0);
    });
  }

  Future<void> getLocationData() async {
    var param = {
      'format': 'jsonv2',
      'lat': '17.037834473969383',
      'lon': '54.14773519468366',
      'zoom': '21',
    };
    var resp = await NetworkService(context).ajax(
      'reverse',
      param,
      isPost: false,
      isFullUrl: true,
      isUseToken: false,
      isProgress: true,
      isFull: false,
    );
    setState(() {
      zoneName = resp['name'];
    });
  }

  Future<void> getOrders(int type) async {
    var param = {
      'action': 'driver_list_v3',
      'params[type]': '$type',
    };
    var resp = await NetworkService(context).ajax(
      'order',
      param,
      isUseToken: true,
      isProgress: true,
      isFull: false,
    );
    if (resp['type'] == Constants.response_type_success) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(offsetBase),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(offsetSm),
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.45),
                          blurRadius: 4.0,
                          offset: Offset(0, 2))
                    ]),
                child: Image.asset('assets/icons/ic_notification.png'),
              ),
              SizedBox(
                width: offsetBase,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: offsetBase, vertical: offsetSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.35), blurRadius: 4.0),
                  ],
                ),
                child: Text(
                  zoneName.isEmpty ? S.of(context).new_salalah_zone : zoneName,
                  style: boldText.copyWith(fontSize: 14.0, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 3.0,
          color: borderColor,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: offsetBase, left: offsetBase, right: offsetBase),
                child: Text(
                  S.of(context).assigned_orders,
                  style: boldText.copyWith(fontSize: 18.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: offsetSm,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var item in assignedOrders)
                        item.itemWidget(context, widget.isEnglish,
                            isShownDate: false),
                    ],
                  ),
                ),
              )
            ],
          ),
          flex: 2,
        ),
        Container(
          width: double.infinity,
          height: 3.0,
          color: borderColor,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: offsetBase, left: offsetBase, right: offsetBase),
                child: Text(
                  S.of(context).nearby_pendings,
                  style: boldText.copyWith(fontSize: 18.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: offsetSm,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var item in pendingOrders) item.pendingWidget(),
                    ],
                  ),
                ),
              )
            ],
          ),
          flex: 3,
        ),
      ],
    );
  }
}
