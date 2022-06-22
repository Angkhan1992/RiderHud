import 'package:flutter/material.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/themes/dimens.dart' as dimen;

class LoginButtonWidget extends Container {
  LoginButtonWidget({
    String title = '',
    double radius = 28.0,
    Widget titleWidget,
    Function() onPressed,
    EdgeInsets margin,
  }) : super(
            margin: margin,
            decoration: BoxDecoration(
              color: onPressed == null? Colors.black.withOpacity(0.2) : Colors.transparent,
                border: Border.all(
                    color: onPressed == null
                        ? Colors.white.withOpacity(0.5)
                        : Colors.white,
                    width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            child: Center(
              // ignore: deprecated_member_use
              child: FlatButton(
                child: titleWidget != null
                    ? titleWidget
                    : Text(
                        title,
                        style: boldText.copyWith(fontSize: dimen.fontMd, color: onPressed == null
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,),
                      ),
                onPressed: () => onPressed(),
              ),
            ));
}
