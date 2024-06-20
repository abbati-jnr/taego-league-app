import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:taego_league_app/main/screens/ProKitLauncher.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/main/utils/dots_indicator/dots_indicator.dart';
import 'package:taego_league_app/theme2/screens/T2SignIn.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Images.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../main.dart';
import '../../main/utils/AppConstant.dart';

class T2WalkThrough extends StatefulWidget {
  static var tag = "/walk_through2";

  final bool isDirect;

  T2WalkThrough({this.isDirect = false});

  @override
  T2WalkThroughState createState() => T2WalkThroughState();
}

class T2WalkThroughState extends State<T2WalkThrough> {
  int currentIndexPage = 0;
  int? pageLength;

  var titles = ["Manage league", "Manage Teams", "Create fixtures"];

  var subTitles = ['Create leagues and invite teams', 'Create teams and invite players', 'Add fixtures'];

  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);

    return Scaffold(
      body: Observer(
        builder: (_) => Stack(
          children: <Widget>[
            Container(
              width: context.width(),
              height: context.height(),
              child: PageView(
                children: <Widget>[
                  WalkThrough(textContent: t2_walk_1),
                  WalkThrough(textContent: t2_walk_2),
                  WalkThrough(textContent: t2_walk_3),
                ],
                onPageChanged: (value) {
                  setState(() => currentIndexPage = value);
                },
              ),
            ),
            Positioned(
              width: context.width(),
              height: 50,
              top: context.height() * 0.58,
              child: Align(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: currentIndexPage,
                  decorator: DotsDecorator(color: t2_view_color, activeColor: t2_colorPrimary),
                ),
              ),
            ),
            Positioned(
              width: context.width(),
              top: context.height() * 0.6,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(titles[currentIndexPage], style: boldTextStyle(size: 20, color: appStore.textPrimaryColor)),
                    SizedBox(height: 10),
                    Center(child: Text(subTitles[currentIndexPage], style: primaryTextStyle(size: 18, color: t2_textColorSecondary), textAlign: TextAlign.center)),
                    //SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: t2AppButton(
                  textContent: t2_lbl_get_started,
                  onPressed: () {
                    changeStatusColor(t2White);
                    T2SignIn().launch(context);
                  },
                ),
              ),
            ),
            SafeArea(
              child: Container(
                width: context.width(),
                height: 60,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Center(
                        child: Text(
                          'Taego League',
                          maxLines: 2,
                          style: boldTextStyle(size: 22, color: appStore.textPrimaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalkThrough extends StatelessWidget {
  final String textContent;

  WalkThrough({Key? key, required this.textContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      height: context.height(),
      child: SizedBox(
        child: Stack(
          children: <Widget>[
            Image.asset(t2_walk_bg, fit: BoxFit.fill, width: context.width(), height: (context.height()) / 1.7),
            SafeArea(
              child: Container(
                width: context.width(),
                height: (context.height()) / 1.7,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                  imageUrl: textContent,
                  width: 300,
                  height: (context.height()) / 2.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
