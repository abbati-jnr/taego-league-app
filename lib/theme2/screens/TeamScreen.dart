import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/theme2/models/models.dart';
import 'package:taego_league_app/theme2/screens/InvitationFormScreen.dart';
import 'package:taego_league_app/theme2/screens/TeamFormScreen.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2DataGenerator.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';

import '../../services/api_services.dart';
import '../utils/T2Widgets.dart';

class TeamScreen extends StatefulWidget {
  static var tag = "/listing_two";

  final bool isDirect;

  TeamScreen({this.isDirect = false});

  @override
  TeamScreenState createState() => TeamScreenState();
}

class TeamScreenState extends State<TeamScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await teamStore.getTeams(context);
  }

  _deleteTeam(int id) async {
    var resp = await ApiService.deleteTeam(context, id);

    if (resp != null) {
      snackBar(context, title: "Team Deleted");
      leagueStore.getLeagues(context);

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
                          TeamFormScreen().launch(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add, color: t2_colorPrimary, size: 16),
                            Text(
                              "Add Team",
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
                    itemCount: teamStore.teams.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var team = teamStore.teams[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Container(
                          decoration: BoxDecoration(color: context.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(10), boxShadow: defaultBoxShadow()),
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: context.scaffoldBackgroundColor,
                            child: Row(
                              children: <Widget>[
                                CachedNetworkImage(
                                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                    imageUrl: team.logo,
                                    width: width / 3,
                                    height: width / 2.8,
                                    fit: BoxFit.fill),
                                Container(
                                  width: width - (width / 3) - 35,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: index % 2 == 0 ? t2_red : t2_colorPrimary,
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                                            ),
                                            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                            child: Text(index % 2 == 0 ? "New" : "Popular", style: primaryTextStyle(color: white, size: 12)),
                                          ),
                                          PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: appStore.textPrimaryColor,
                                            ),
                                            onSelected: (dynamic value) async {
                                              if (value == 'edit') {
                                                TeamFormScreen(team: team).launch(context);
                                              }
                                              if (value == 'invite') {
                                                InvitationFormScreen(teamId: team.id).launch(context);
                                              }
                                              if (value == 'delete') {
                                                await showDialog(context: context, builder: (BuildContext context) => CustomDialog(
                                                        () => {
                                                      _deleteTeam(team.id)
                                                    }
                                                ));
                                              }
                                            },
                                            itemBuilder: (context) {
                                              List<PopupMenuEntry<Object>> list = [];
                                              list.add(
                                                PopupMenuItem(
                                                  child: Text("Invite", style: primaryTextStyle()),
                                                  value: 'invite',
                                                ),
                                              );
                                              list.add(
                                                PopupMenuItem(
                                                  child: Text("Edit", style: primaryTextStyle()),
                                                  value: 'edit',
                                                ),
                                              );
                                              list.add(
                                                PopupMenuItem(
                                                  child: Text("Delete", style: primaryTextStyle()),
                                                  value: 'delete',
                                                ),
                                              );
                                              return list;
                                            },
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(team.name, style: primaryTextStyle(color: appStore.textPrimaryColor, size: 18)),
                                            // SizedBox(height: 4),
                                            // Text(mListings[index].duration, style: primaryTextStyle(size: 14)),
                                            SizedBox(height: 4),
                                            Text(team.description, style: primaryTextStyle(size: 14), maxLines: 1),
                                            SizedBox(height: 4),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            margin: EdgeInsets.all(0),
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
