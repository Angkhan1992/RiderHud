import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class SwipeToActionWidget extends StatefulWidget {
  final String actionText;
  final void Function() action;
  final bool isDisabled;

  SwipeToActionWidget({
    this.actionText,
    this.action,
    this.isDisabled = false,
  });

  @override
  _SwipeToActionWidgetState createState() => _SwipeToActionWidgetState();
}

class _SwipeToActionWidgetState extends State<SwipeToActionWidget> {
  final PageController _controller = PageController(
    keepPage: false,
    initialPage: 1,
  );

  bool actionPerformed = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() async {
      if (_controller.page == 0 && !actionPerformed) {
        setState(() {
          actionPerformed = true;
        });
        await widget.action();
        _controller.jumpToPage(1);
        setState(() {
          actionPerformed = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 48,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: offsetSm + 4,
            horizontal: offsetBase,
          ),
          decoration: BoxDecoration(
            color: widget.isDisabled ? mainColor.withOpacity(0.5) : mainColor,
            borderRadius: BorderRadius.circular(offsetSm),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/swipe_icon.svg",
              ),
              Text(
                widget.actionText,
                style: boldText,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(offsetSm),
          child: Container(
            height: 48,
            child: PageView(
              allowImplicitScrolling: false,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              reverse: false,
              physics: ScrollPhysics(
                parent: widget.isDisabled
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(offsetSm),
                  ),
                  child: Text(
                    widget.actionText,
                    style: boldText,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(offsetSm),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
