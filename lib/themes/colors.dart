import 'package:flutter/material.dart';

const Color mainColor = Color(0xff064264);
const Color dividerColor = Color(0xfff6f6f6);
const Color orangeColor = Color(0xfff66c00);
const Color purpleColor = Color(0xff4F38DE);
// const Color orangeColor = Color(0xffFF6C00);

const Color borderColor = Color(0xffdddddd);

const Color greyTextColor = Color(0xff858585);
const Color darkGreyTextColor = Color(0xff605d5d);
const Color lightGreyTextColor = Color(0xffc4c4c4);
const Color redTextColor = Color(0xffF1003A);

const Color redBadgeColor = Color(0xffEA4600);
const Color orangeBadgeColor = Color(0xffEAC400);
const Color greenBadgeColor = Color(0xff00DE09);

Map<int, Color> _matMainColors =
{
  50:Color.fromRGBO(6,66,99, .1),
  100:Color.fromRGBO(6,66,99, .2),
  200:Color.fromRGBO(6,66,99, .3),
  300:Color.fromRGBO(6,66,99, .4),
  400:Color.fromRGBO(6,66,99, .5),
  500:Color.fromRGBO(6,66,99, .6),
  600:Color.fromRGBO(6,66,99, .7),
  700:Color.fromRGBO(6,66,99, .8),
  800:Color.fromRGBO(6,66,99, .9),
  900:Color.fromRGBO(6,66,99, 1),
};

MaterialColor matMainColor = MaterialColor(0xff064264, _matMainColors);