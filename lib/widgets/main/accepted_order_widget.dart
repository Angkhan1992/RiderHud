import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/order_model.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/widgets/swipe_to_action.dart';

class AcceptedOrderWidget extends StatefulWidget {
  final OrderModel order;
  final Function() directions;
  final Function() arrival;
  const AcceptedOrderWidget(
      {Key key, this.order, this.directions, this.arrival})
      : super(key: key);

  @override
  _AcceptedOrderWidgetState createState() => _AcceptedOrderWidgetState();
}

class _AcceptedOrderWidgetState extends State<AcceptedOrderWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
        initialChildSize: 260.0 / height,
        maxChildSize: 0.95,
        minChildSize: 260.0 / height,
        builder: (context, controller) {
          return SingleChildScrollView(
            controller: controller,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: offsetMd, vertical: offsetSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(offsetSm),
                  topRight: Radius.circular(offsetSm),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 4.0,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Container(
                        width: 42.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: 18.0,
                            height: 18.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0)),
                            ),
                            child: Text(
                              '1',
                              style: boldText.copyWith(fontSize: 13.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Text(
                    'Snacks ’N’ More - Saada',
                    style:
                        boldText.copyWith(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Text(
                    '6 ${S.of(context).items}',
                    style: boldText.copyWith(
                        fontSize: 14.0, color: darkGreyTextColor),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 155.0,
                        height: 36.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: InkWell(
                          onTap: () => widget.directions(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.directions,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: offsetSm,
                              ),
                              Text(
                                S.of(context).directions,
                                style: boldText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: offsetBase,
                      ),
                      Container(
                        width: 36.0,
                        height: 36.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: lightGreyTextColor,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: offsetLg,
                  ),
                  Text(
                    S.of(context).pick_up_at,
                    style:
                        boldText.copyWith(fontSize: 19.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Container(
                    width: 20.0,
                    height: 4,
                    color: mainColor,
                  ),
                  SizedBox(
                    height: offsetBase,
                  ),
                  Text(
                    S.of(context).pick_up_detail,
                    style: boldText.copyWith(color: greyTextColor),
                  ),
                  SizedBox(
                    height: offsetLg,
                  ),
                  SwipeToActionWidget(
                    actionText: S.of(context).slider_after_arrival,
                    action: () => widget.arrival(),
                  ),
                  SizedBox(height: offsetMd),
                  Container(
                    width: double.infinity,
                    height: 2.0,
                    color: lightGreyTextColor,
                  ),
                  SizedBox(height: offsetMd),
                  Text(
                    S.of(context).customer,
                    style:
                        boldText.copyWith(fontSize: 19.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Container(
                    width: 20.0,
                    height: 4,
                    color: mainColor,
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Row(
                    children: [
                      Text(
                        'Hashim Al-Haddadi.',
                        style: boldText.copyWith(
                            fontSize: 14.0, color: greyTextColor),
                      ),
                      Spacer(),
                      Container(
                        width: 36.0,
                        height: 36.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: lightGreyTextColor,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: offsetXMd,
                      ),
                      Container(
                        width: 36.0,
                        height: 36.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: lightGreyTextColor,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: Image.asset(
                          'assets/icons/ic_chat.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: offsetXMd,
                  ),
                  Container(
                    width: double.infinity,
                    height: 2.0,
                    color: lightGreyTextColor,
                  ),
                  SizedBox(height: offsetMd),
                  Text(
                    S.of(context).order_detail,
                    style:
                        boldText.copyWith(fontSize: 19.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Container(
                    width: 20.0,
                    height: 4,
                    color: mainColor,
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Row(
                    children: [
                      Text(
                        '6 ${S.of(context).items} - #0000053462 (',
                        style: boldText.copyWith(
                            fontSize: 14.0, color: Colors.black),
                      ),
                      Text(
                        '#24',
                        style: boldText.copyWith(
                            fontSize: 14.0, color: lightGreyTextColor),
                      ),
                      Text(
                        ')',
                        style: boldText.copyWith(
                            fontSize: 14.0, color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        '14.500 OMR',
                        style: boldText.copyWith(
                            fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  for (var item in Constants.deliveryOrdersTitle)
                    Text(
                      item,
                      style: boldText.copyWith(
                          fontSize: 14.0, color: lightGreyTextColor),
                    ),
                  SizedBox(
                    height: offsetLg,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
