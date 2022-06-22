import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class ChatModel {
  String name;
  String id;
  String orderid;
  List<MessageModel> messages = [];

  Widget itemWidget({bool isOpened = false, bool isEnglish}) {
    return Container(
      margin: EdgeInsets.only(
          top: 16.0, bottom: 12.0, left: offsetBase, right: offsetBase),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(offsetBase),
                  topRight: Radius.circular(offsetBase)),
            ),
            elevation: 2,
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(offsetBase),
                  topRight: Radius.circular(offsetBase)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: offsetMd, vertical: offsetXSm),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 1),
                          blurRadius: 2.0)
                    ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: isEnglish? Alignment.centerLeft : Alignment.centerRight,
                            child: Icon(
                              isOpened
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up,
                              color: mainColor,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Hashim Al-Haddadi',
                              style: boldText.copyWith(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                            Text(
                              '#0000053462(#24)',
                              style: boldText.copyWith(
                                  fontSize: 12.0, color: lightGreyTextColor),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: !isEnglish? Alignment.centerLeft : Alignment.centerRight,
                            child: Text(
                              'Request Location',
                              style: boldText.copyWith(
                                  fontSize: 10.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isOpened)
                    Container(
                      padding: EdgeInsets.all(offsetBase),
                      color: Color(0xfff6f6f6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(offsetSm),
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(offsetSm),
                                        bottomLeft: Radius.circular(offsetSm),
                                        bottomRight: Radius.circular(offsetSm),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: Offset(0, 1),
                                            blurRadius: 2.0)
                                      ],
                                    ),
                                    child: Text(
                                      'Please share your location',
                                      style: boldText.copyWith(fontSize: 12.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: offsetXSm,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: offsetBase),
                                    child: Text(
                                      '9:42 pm',
                                      style: boldText.copyWith(
                                          fontSize: 11.0,
                                          color: lightGreyTextColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(offsetSm),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(offsetSm),
                                    bottomLeft: Radius.circular(offsetSm),
                                    bottomRight: Radius.circular(offsetSm),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: Offset(0, 1),
                                        blurRadius: 2.0)
                                  ],
                                ),
                                child: Text(
                                  'I just shared my location.\nThanks!',
                                  style: boldText.copyWith(
                                      fontSize: 12.0, color: mainColor),
                                ),
                              ),
                              SizedBox(
                                height: offsetXSm,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: offsetBase),
                                child: Text(
                                  '9:42 pm',
                                  style: boldText.copyWith(
                                      fontSize: 11.0,
                                      color: lightGreyTextColor),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                width: 36.0,
                                height: 36.0,
                                padding: EdgeInsets.all(offsetSm),
                                decoration: BoxDecoration(
                                  color: Color(0xfff6f6f6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: Offset(0, 1),
                                        blurRadius: 2.0)
                                  ],
                                ),
                                child: Image.asset('assets/icons/ic_chat.png',),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageModel {
  String content;
  String type;
  String datetime;
  String userid;
}
