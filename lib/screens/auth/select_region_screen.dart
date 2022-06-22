import 'package:flutter/material.dart';
import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/services/pref_service.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';
import 'package:riderhub/utils/params.dart';

class SelectRegionScreen extends StatefulWidget {
  const SelectRegionScreen({Key key}) : super(key: key);

  @override
  _SelectRegionScreenState createState() => _SelectRegionScreenState();
}

class _SelectRegionScreenState extends State<SelectRegionScreen> {
  var lang = '';

  @override
  void initState() {
    super.initState();

    setLang();
  }

  void setLang() async {
    lang = await PrefService().getLanguage();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        brightness: Brightness.dark,
        title: Text(
          S.of(context).region_picker_title,
          style: boldText.copyWith(fontSize: 18.0),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: offsetSm),
          child: Column(
            children: [
              for (var region in Params.regionModels)
                InkWell(
                  onTap: () => Navigator.of(context).pop(region),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: offsetMd, vertical: offsetBase),
                        child: Text(
                          lang == 'en'? region.title : region.title_ar,
                          style: boldText.copyWith(fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: offsetBase),
                        width: double.infinity,
                        height: 1,
                        color: lightGreyTextColor,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
