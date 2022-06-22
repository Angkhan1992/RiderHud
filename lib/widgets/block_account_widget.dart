import 'dart:ui';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class BlockAccountWidget extends StatefulWidget {
  final bool isBlock;
  const BlockAccountWidget({Key key, this.isBlock = true}) : super(key: key);

  @override
  _BlockAccountWidgetState createState() => _BlockAccountWidgetState();
}

class _BlockAccountWidgetState extends State<BlockAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.3),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.isBlock)
                Column(
                  children: [
                    Image.asset(
                      'assets/icons/ic_break.png',
                      width: 55,
                      height: 55,
                    ),
                    SizedBox(
                      height: offsetBase,
                    ),
                  ],
                ),
              Text(
                widget.isBlock
                    ? S.of(context).account_block
                    : S.of(context).you_break,
                style: boldText.copyWith(fontSize: 24.0, color: Colors.black),
              ),
              SizedBox(
                height: offsetXLg,
              ),
              CircularCountDownTimer(
                duration: 900,
                initialDuration: 0,
                controller: CountDownController(),
                width: 128,
                height: 128,
                ringColor: mainColor.withOpacity(0.5),
                ringGradient: null,
                fillColor: mainColor,
                fillGradient: null,
                backgroundColor: Colors.transparent,
                backgroundGradient: null,
                strokeWidth: 8.0,
                strokeCap: StrokeCap.round,
                textStyle:
                    boldText.copyWith(fontSize: 28.0, color: Colors.black),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  print('Countdown Started');
                },
                onComplete: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
              SizedBox(
                height: offsetSm,
              ),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    child: Text(
                      S.of(context).min_left,
                      style: boldText.copyWith(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
