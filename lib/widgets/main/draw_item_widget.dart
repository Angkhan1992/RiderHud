import 'package:flutter/material.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/colors.dart' as color;
import 'package:riderhub/themes/textstyle.dart';

class DrawItemWidget extends Container {
  DrawItemWidget({
    @required String icon,
    @required String title,
    bool isSelected = false,
    String description = '',
    @required Function() action,
  }) : super(
          margin: EdgeInsets.only(top: 1.0),
          width: double.infinity,
          padding: isSelected
              ? EdgeInsets.only(
                  top: offsetXMd,
                  left: offsetBase,
                  right: offsetBase,
                  bottom: 12.0)
              : EdgeInsets.symmetric(horizontal: offsetBase, vertical: 12.0),
          color: Colors.white,
          child: InkWell(
            onTap: () => action(),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 24.0,
                  height: 24.0,
                ),
                SizedBox(
                  width: offsetSm,
                ),
                Text(
                  title,
                  style: boldText.copyWith(
                      fontSize: isSelected ? 18.0 : 14.0,
                      color:
                          isSelected ? Colors.black : color.darkGreyTextColor),
                ),
                Spacer(),
                if (description.isNotEmpty)
                  Text(description,
                      style: boldText.copyWith(
                          fontSize: 14.0, color: color.lightGreyTextColor))
              ],
            ),
          ),
        );
}
