import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/themes/colors.dart' as color;
import 'package:riderhub/utils/constants.dart';
import 'package:riderhub/utils/params.dart';
import 'package:riderhub/widgets/main/draw_item_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class DrawMenu extends StatelessWidget {
  final int selectedItem;
  final bool isEnglish;
  final Function(int) onSelectMenu;
  final Function(String) changeLanguage;
  final Function() requestBreak;
  final Function() extendDuty;

  const DrawMenu({
    Key key,
    this.selectedItem = 0,
    this.isEnglish = true,
    this.onSelectMenu,
    this.changeLanguage,
    this.requestBreak,
    this.extendDuty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menuItems = [
      {
        'icon': 'assets/icons/ic_duty_option.png',
        'title': S.of(context).duty_option,
        'desc': '',
      },
      {
        'icon': 'assets/icons/ic_break.png',
        'title': S.of(context).request_break,
        'desc': '',
      },
      {
        'icon': 'assets/icons/ic_extended.png',
        'title': S.of(context).extend_duty,
        'desc': S.of(context).one_time_only,
      },
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 2,
            color: color.dividerColor,
          ),
          Container(
            width: double.infinity,
            height: 44.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              S.of(context).rate_break_profile,
              style: mediumText.copyWith(color: color.redTextColor),
            ),
          ),
          for (var item in menuItems)
            DrawItemWidget(
              icon: item['icon'],
              title: item['title'],
              isSelected: selectedItem == menuItems.indexOf(item),
              description: item['desc'],
              action: () {
                var index = menuItems.indexOf(item);
                switch (index) {
                  case 1:
                    requestBreak();
                    break;
                  case 2:
                    extendDuty();
                    break;
                  default:
                    break;
                }
              },
            ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: offsetBase),
            decoration: BoxDecoration(
                color: color.mainColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(offsetBase),
                    topRight: Radius.circular(offsetBase))),
            child: Column(
              children: [
                Container(
                  width: 108.0,
                  height: 108.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: color.lightGreyTextColor, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(54.0)),
                  ),
                  child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(54.0)),
                          child: CachedNetworkImage(
                            imageUrl: Params.currentUser.avatar_path,
                            height: 108,
                            width: 108,
                            placeholder: (context, url) => Padding(
                              padding: const EdgeInsets.all(offsetBase),
                              child: Stack(
                                children: [
                                  Center(
                                      child: SvgPicture.asset(
                                    'assets/icons/ic_avatar.svg',
                                    width: 72.0,
                                    height: 72.0,
                                    color: color.mainColor,
                                  )),
                                  Center(child: CupertinoActivityIndicator()),
                                ],
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: offsetBase),
                  child: Text(
                    isEnglish
                        ? Params.currentUser.full_name ?? ''
                        : Params.currentUser.short_name ?? '',
                    style: boldText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: offsetSm),
                  child: Text(
                    '+${Params.currentUser.phone_number}',
                    style: boldText.copyWith(fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: offsetSm),
                  child: Text(
                    'RHID:${Params.currentUser.rhid}',
                    style: boldText.copyWith(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: offsetXMd, vertical: offsetBase),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0)),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => changeLanguage('en'),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: offsetSm, vertical: offsetXSm),
                          decoration: BoxDecoration(
                            color: !isEnglish ? Colors.white : color.mainColor,
                            border:
                                Border.all(color: color.mainColor, width: 2.0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(isEnglish ? 6.0 : 0.0),
                              bottomRight:
                                  Radius.circular(!isEnglish ? 6.0 : 0.0),
                            ),
                          ),
                          child: Text(
                            'EN',
                            style: boldText.copyWith(
                              fontSize: 14.0,
                              color: isEnglish ? Colors.white : color.mainColor,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => changeLanguage('ar'),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: offsetSm, vertical: offsetXSm),
                          decoration: BoxDecoration(
                            color: isEnglish ? Colors.white : color.mainColor,
                            border:
                                Border.all(color: color.mainColor, width: 2.0),
                            borderRadius: BorderRadius.only(
                              bottomRight:
                                  Radius.circular(isEnglish ? 6.0 : 0.0),
                              topLeft: Radius.circular(!isEnglish ? 6.0 : 0.0),
                            ),
                          ),
                          child: Text(
                            'AR',
                            style: boldText.copyWith(
                              fontSize: 14.0,
                              color:
                                  !isEnglish ? Colors.white : color.mainColor,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: color.mainColor,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150.0,
                      height: 150.0,
                      child: Stack(
                        children: [
                          charts.PieChart(
                            Constants.createRandomData(),
                            animate: false,
                            defaultRenderer: new charts.ArcRendererConfig(
                                arcWidth: 8,
                                startAngle: 3 / 2 * pi,
                                arcLength: 7 / 5 * pi),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '73%',
                              style: boldText.copyWith(
                                  fontSize: 28.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: offsetMd),
                      child: Row(
                        children: [
                          Container(
                            width: 3,
                            height: 20.0,
                            color: color.orangeColor,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: offsetSm),
                            child: Text(
                              'Medium Level',
                              style: boldText.copyWith(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
