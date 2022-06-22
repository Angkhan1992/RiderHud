import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class AcceptOrderWidget extends StatefulWidget {
  final String title;
  final int count;
  final String price;
  final Function() timeout;
  final Function() accept;

  const AcceptOrderWidget(
      {Key key, this.title, this.count, this.price, this.timeout, this.accept})
      : super(key: key);

  @override
  _AcceptOrderWidgetState createState() => _AcceptOrderWidgetState();
}

class _AcceptOrderWidgetState extends State<AcceptOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: offsetMd, vertical: offsetSm),
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: offsetSm,
                    ),
                    Text(
                      widget.title,
                      style: boldText.copyWith(
                          fontSize: 20.0, color: Colors.black),
                    ),
                    Text(
                      '${widget.count} ${S.of(context).items}',
                      style: boldText.copyWith(color: darkGreyTextColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: offsetBase),
                child: CircularCountDownTimer(
                  duration: 60,
                  initialDuration: 0,
                  controller: CountDownController(),
                  width: 64,
                  height: 64,
                  ringColor: Colors.white,
                  ringGradient: null,
                  fillColor: mainColor,
                  fillGradient: null,
                  backgroundColor: Colors.white,
                  backgroundGradient: null,
                  strokeWidth: 4.0,
                  strokeCap: StrokeCap.round,
                  textStyle:
                      boldText.copyWith(fontSize: 28.0, color: Colors.black),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    print('Countdown Started');
                  },
                  onComplete: () => widget.timeout(),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: offsetBase),
            width: double.infinity,
            height: 2,
            color: lightGreyTextColor,
          ),
          SizedBox(
            height: offsetSm,
          ),
          Text(
            widget.price,
            style: boldText.copyWith(fontSize: 28.0, color: Colors.black),
          ),
          SizedBox(
            height: offsetSm,
          ),
          Text(
            S.of(context).customer_payment,
            style: boldText.copyWith(fontSize: 14.0, color: lightGreyTextColor),
          ),
          SizedBox(
            height: offsetSm,
          ),
          InkWell(
            onTap: () => widget.accept(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: offsetXLg),
              width: double.infinity,
              alignment: Alignment.center,
              height: 45.0,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Text(
                S.of(context).accept,
                style: boldText.copyWith(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
