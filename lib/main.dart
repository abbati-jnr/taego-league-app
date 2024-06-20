import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:taego_league_app/stores/fixture_store.dart';
import 'package:taego_league_app/stores/league_store.dart';
import 'package:taego_league_app/stores/team_store.dart';
import 'package:taego_league_app/stores/user_store.dart';
import 'package:taego_league_app/theme2/screens/T2Walkthrough.dart';
import 'package:flutter/services.dart';
import 'locale/Languages.dart';
import 'main/store/AppStore.dart';
import 'main/utils/AppConstant.dart';
import 'main/utils/AppTheme.dart';


/// This variable is used to get dynamic colors when theme mode is changed
AppStore appStore = AppStore();
LeagueStore leagueStore = LeagueStore();
FixtureStore fixtureStore = FixtureStore();
TeamStore teamStore = TeamStore();
UserStore userStore = UserStore();

BaseLanguage? language;

late String darkMapStyle;
late String lightMapStyle;

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: 'Taego League',
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        home: T2WalkThrough(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorColor = const Color(0xFF2A3656)
    ..backgroundColor = Colors.transparent
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorWidget = SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Image.asset(
          //   logo1,
          //   width: 30,
          //   height: 30,
          // ),
          // you can replace
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2A3656)),
            strokeWidth: 0.7,
          ),
        ],
      ),
    )
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.custom
    ..boxShadow = <BoxShadow>[]
    ..maskColor = const Color(0xFF2A3656).withOpacity(0.15)
    ..dismissOnTap = false;
}
