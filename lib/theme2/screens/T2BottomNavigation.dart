import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/theme2/screens/FixtureScreen.dart';
import 'package:taego_league_app/theme2/screens/LeagueScreen.dart';
import 'package:taego_league_app/theme2/screens/ProfileScreen.dart';
import 'package:taego_league_app/theme2/screens/TeamScreen.dart';
import 'package:taego_league_app/theme2/utils/T2BubbleBotoomBar.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

class T2BottomNavigation extends StatefulWidget {
  static var tag = "/T2BottomNavigation";

  @override
  T2BottomNavigationState createState() => T2BottomNavigationState();
}

class T2BottomNavigationState extends State<T2BottomNavigation> {
  int currentIndex = 0;
  var _pages = <Widget>[
    LeagueScreen(),
    FixtureScreen(),
    TeamScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(appStore.appBarColor!);

    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        backgroundColor: appStore.appBarColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        onTap: changePage,
        hasNotch: false,
        hasInk: true,
        inkColor: t2_colorPrimaryLight,
        items: <BubbleBottomBarItem>[
          tab(Icons.home, 'League'),
          tab(Icons.account_tree_outlined, 'Fixture'),
          tab(Icons.account_balance_rounded, 'Team'),
          tab(Icons.person_outline, 'Profile'),
        ],
      ),
      body: _pages.elementAt(currentIndex),
    );
  }
}
