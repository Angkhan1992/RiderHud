import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/models/order_model.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/constants.dart';

class ConfirmItemWidget extends Container {
  ConfirmItemWidget(BuildContext context,
      {@required OrderModel orderModel, Function() confirm, Function() goBack})
      : super(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.5),
          child: Column(
            children: [
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: offsetMd, vertical: offsetBase),
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
                  children: [
                    Text(
                      S.of(context).confirm_title,
                      style: boldText.copyWith(
                          fontSize: 22.0, color: Colors.black),
                    ),
                    SizedBox(
                      height: offsetBase,
                    ),
                    Text(
                      S.of(context).confirm_desc,
                      style: boldText.copyWith(
                          fontSize: 14.0, color: greyTextColor),
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
                      Container(
                        width: double.infinity,
                        child: Text(
                          item,
                          style: boldText.copyWith(
                              fontSize: 14.0, color: lightGreyTextColor),
                        ),
                      ),
                    SizedBox(
                      height: offsetLg,
                    ),
                    InkWell(
                      onTap: () => confirm(),
                      child: Container(
                        width: double.infinity,
                        height: 45.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(22.5)),
                        ),
                        child: Text(
                          S.of(context).confirm,
                          style: boldText.copyWith(fontSize: 17.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: offsetSm,
                    ),
                    InkWell(
                      onTap: () => goBack(),
                      child: Container(
                        width: double.infinity,
                        height: 45.0,
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).go_back,
                          style: boldText.copyWith(
                              fontSize: 17.0, color: mainColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}
