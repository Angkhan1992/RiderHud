import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class BeforeDialogWidget extends StatefulWidget {
  final Function() onActionStart;
  const BeforeDialogWidget({Key key, this.onActionStart}) : super(key: key);

  @override
  _BeforeDialogWidgetState createState() => _BeforeDialogWidgetState();
}

class _BeforeDialogWidgetState extends State<BeforeDialogWidget> {
  var isCheckItems = [false, false, false, false];

  bool getAllChecked() {
    for (var item in isCheckItems) {
      if (!item) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var checkItems = [
      S.of(context).charge_phone_data,
      S.of(context).enough_fuel,
      S.of(context).thermal_bag,
      S.of(context).company_t_shirt,
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(offsetBase),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(offsetBase),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(offsetBase),
                      topRight: Radius.circular(offsetBase)),
                ),
                child: Text(
                  S.of(context).before_you_begin,
                  style: boldText.copyWith(color: Colors.black),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      S.of(context).before_dialog_desc,
                      style: boldText.copyWith(color: greyTextColor),
                    ),
                    for (var item in checkItems)
                      Column(
                        children: [
                          SizedBox(
                            height: offsetSm,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: lightGreyTextColor,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: offsetXMd, vertical: offsetSm),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isCheckItems[checkItems.indexOf(item)] =
                                      !isCheckItems[checkItems.indexOf(item)];
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    isCheckItems[checkItems.indexOf(item)]
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: mainColor,
                                  ),
                                  SizedBox(
                                    width: offsetBase,
                                  ),
                                  Text(
                                    item,
                                    style: boldText.copyWith(
                                        color: darkGreyTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: lightGreyTextColor,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: offsetSm,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: offsetSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(offsetBase),
                      bottomRight: Radius.circular(offsetBase)),
                ),
                child: InkWell(
                  onTap: () {
                    if (getAllChecked()) {
                      Navigator.of(context, rootNavigator: true).pop();
                      widget.onActionStart();
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: getAllChecked()
                          ? mainColor
                          : mainColor.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Text(
                      S.of(context).start_riding,
                      style: boldText.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
