import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/order_model.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/widgets/swipe_to_action.dart';

class DeliveryOrderWidget extends StatefulWidget {
  final OrderModel order;
  final Function() directions;
  final Function() arrival;
  final Function() call;
  final Function() message;
  const DeliveryOrderWidget(
      {Key key,
      this.order,
      this.directions,
      this.arrival,
      this.call,
      this.message})
      : super(key: key);

  @override
  _DeliveryOrderWidgetState createState() => _DeliveryOrderWidgetState();
}

class _DeliveryOrderWidgetState extends State<DeliveryOrderWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
        initialChildSize: 216.0 / height,
        maxChildSize: 0.8,
        minChildSize: 216.0 / height,
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
                mainAxisSize: MainAxisSize.min,
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
                  Text(
                    S.of(context).delivery_for,
                    style:
                        boldText.copyWith(fontSize: 14.0, color: greyTextColor),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Text(
                    'Hashim Al-Haddadi',
                    style:
                        boldText.copyWith(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Text(
                    'Sahlnoot, Al Farabi ST [ Sahnoot Zone ]',
                    style:
                        boldText.copyWith(fontSize: 14.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => widget.directions(),
                        child: Container(
                          width: 155.0,
                          height: 36.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: lightGreyTextColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          child: Text(
                            S.of(context).directions,
                            style: boldText.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => widget.call(),
                        child: Container(
                          width: 36.0,
                          height: 36.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: lightGreyTextColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          child: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: offsetXMd,
                      ),
                      InkWell(
                        onTap: () => widget.message(),
                        child: Container(
                          width: 36.0,
                          height: 36.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: lightGreyTextColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          child: Image.asset(
                            'assets/icons/ic_chat.png',
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: offsetLg,
                  ),
                  Text(
                    S.of(context).drop_off,
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
                  Text(
                    S.of(context).drop_off_title,
                    style: boldText.copyWith(color: greyTextColor),
                  ),
                  SizedBox(
                    height: offsetLg,
                  ),
                  SwipeToActionWidget(
                    actionText: S.of(context).drop_off_result,
                    action: () => widget.arrival(),
                  ),
                  SizedBox(
                    height: offsetBase,
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: lightGreyTextColor,
                  ),
                  SizedBox(
                    height: offsetBase,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/ic_note.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      SizedBox(
                        width: offsetSm,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).notes,
                            style: boldText.copyWith(
                                fontSize: 14.0, color: darkGreyTextColor),
                          ),
                          SizedBox(
                            height: offsetBase,
                          ),
                          Text(
                            S.of(context).notes_detail,
                            style: boldText.copyWith(
                                fontSize: 14.0, color: darkGreyTextColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: offsetLg,
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: lightGreyTextColor,
                  ),
                  SizedBox(
                    height: offsetLg,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_order_detail.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      SizedBox(
                        width: offsetSm,
                      ),
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
