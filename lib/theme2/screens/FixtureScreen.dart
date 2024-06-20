import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/theme2/models/models.dart';
import 'package:taego_league_app/theme2/screens/FixtureFormScreen.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2DataGenerator.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';

import '../../services/api_services.dart';
import '../utils/T2Widgets.dart';

class FixtureScreen extends StatefulWidget {
  static var tag = "/listing_two";

  final bool isDirect;

  FixtureScreen({this.isDirect = false});

  @override
  FixtureScreenState createState() => FixtureScreenState();
}

class FixtureScreenState extends State<FixtureScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await fixtureStore.getFixtures(context);
  }

  _deleteFixture(int id) async {
    var resp = await ApiService.deleteFixture(context, id);

    if (resp != null) {
      snackBar(context, title: "Fixture Deleted");
      fixtureStore.getFixtures(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    return Scaffold(
        body: Observer(
          builder: (_) => Container(
            child: Column(
              children: <Widget>[
                18.height,
                Container(
                  padding: EdgeInsets.only(left: 28, right: 28, top: 20, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Center(
                          child: Text('Taego', maxLines: 2, style: boldTextStyle(size: 22, color: t2_textColorPrimary)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FixtureFormScreen().launch(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add, color: t2_colorPrimary, size: 16),
                            Text(
                              "Add Fixture",
                              style: primaryTextStyle(size: 16, color: t2_colorPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    itemCount: fixtureStore.fixtures.length,
                    itemBuilder: (context, index) {
                      var fixture = fixtureStore.fixtures[index];
                      return Slidable(
                        key: ValueKey(index),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  SlidableAction(
                                    label: '',
                                    backgroundColor: Colors.transparent,
                                    icon: Icons.edit,
                                    autoClose: true,
                                    foregroundColor: Colors.transparent,
                                    onPressed: (_) {},
                                  ),
                                  RotatedBox(
                                    quarterTurns: -1,
                                    child: Text("Edit", style: boldTextStyle(color: white, letterSpacing: 5.0)).center(),
                                  )
                                ],
                                alignment: Alignment.center,
                              ),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: t2_green),
                              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              alignment: Alignment.center,
                            ).expand(),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  SlidableAction(
                                    label: '',
                                    backgroundColor: Colors.red,
                                    icon: Icons.edit,
                                    autoClose: true,
                                    foregroundColor: Colors.transparent,
                                    onPressed: (_) async {
                                      await showDialog(context: context, builder: (BuildContext context) => CustomDialog(
                                              () => {
                                            _deleteFixture(fixture.id)
                                          }
                                      ));
                                    },
                                  ),
                                  RotatedBox(
                                    quarterTurns: -1,
                                    child: Text("Delete", style: boldTextStyle(color: white, letterSpacing: 5.0)).center(),
                                  )
                                ],
                                alignment: Alignment.center,
                              ),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: t2_red),
                              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              alignment: Alignment.center,
                            ).expand(),
                          ],
                        ),

                        /*dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),*/
                        child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(boxShadow: defaultBoxShadow(), borderRadius: BorderRadius.circular(12)),
                          child: IntrinsicHeight(
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: context.scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(color: t2_colorPrimary, width: 10),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                                imageUrl: 'https://m.media-amazon.com/images/I/71PyYnmJ1BL.jpg',
                                                width: width / 5,
                                                height: 100,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 16),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(fixture.league.name, style: boldTextStyle(color: appStore.textPrimaryColor), maxLines: 2),
                                                      Text(fixture.date.toLocal().toString(), style: primaryTextStyle(size: 16, color: appStore.textSecondaryColor)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Text(fixture.team1.name, style: primaryTextStyle(size: 16, color: appStore.textSecondaryColor), maxLines: 2),
                                          Text('VS', style: primaryTextStyle(size: 16, color: appStore.textSecondaryColor), maxLines: 2),
                                          Text(fixture.team2.name, style: primaryTextStyle(size: 16, color: appStore.textSecondaryColor), maxLines: 2),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
