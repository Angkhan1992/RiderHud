import 'package:flutter/material.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class NavigatorService {
  final BuildContext context;

  NavigatorService(this.context);

  void showCustomBottomModal(Widget child) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(offsetSm),
            topLeft: Radius.circular(offsetSm),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (_) => Container(
              padding: EdgeInsets.symmetric(
                  vertical: offsetSm, horizontal: offsetXMd),
              child: child,
            ));
  }

  void pushToWidget({
    @required Widget screen,
    bool replace = false,
    Function(dynamic) pop,
  }) {
    if (replace) {
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute<Object>(builder: (context) => screen))
          .then((value) => {if (pop != null) pop(value)});
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<Object>(builder: (context) => screen))
          .then((value) => {if (pop != null) pop(value)});
    }
  }

  void showSnackbar(
      String content,
      GlobalKey<ScaffoldState> _scaffoldKey, {
        SnackBarType type = SnackBarType.SUCCESS,
      }) {
    var backgroundColor = Colors.white;
    switch (type) {
      case SnackBarType.SUCCESS:
        backgroundColor = Colors.green;
        break;
      case SnackBarType.WARING:
        backgroundColor = Colors.orange;
        break;
      case SnackBarType.INFO:
        backgroundColor = Colors.blueGrey;
        break;
      case SnackBarType.ERROR:
        backgroundColor = Colors.red;
        break;
    }

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(offsetSm)),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(offsetBase),
          child: Text(
            content,
            style: mediumText.copyWith(fontSize: fontBase),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(milliseconds: 1500),
    ));
  }
}

enum SnackBarType { SUCCESS, WARING, INFO, ERROR }
