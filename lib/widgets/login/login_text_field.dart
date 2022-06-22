import 'package:flutter/material.dart';
import 'package:riderhub/themes/dimens.dart' as dimen;
import 'package:riderhub/themes/textstyle.dart';

class LoginTextField extends Container {
  LoginTextField({
    double height = 48.0,
    double radius = 24.0,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController controller,
    bool isPassword = false,
    String hint,
    EdgeInsets margin = EdgeInsets.zero,
  }) : super(
          width: double.infinity,
          height: height,
          margin: margin,
          padding: EdgeInsets.symmetric(horizontal: dimen.offsetXMd),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.29),
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: boldText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  boldText.copyWith(color: Colors.white.withOpacity(0.3)),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            obscureText: isPassword,
            cursorColor: Colors.white,
          ),
        );
}
