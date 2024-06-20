import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/services/api_services.dart';
import 'package:taego_league_app/theme2/screens/T2BottomNavigation.dart';
import 'package:taego_league_app/theme2/screens/T2SignUp.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../main.dart';

class T2SignIn extends StatefulWidget {
  static var tag = "/T2SignIn";

  @override
  T2SignInState createState() => T2SignInState();
}

class T2SignInState extends State<T2SignIn> {
  bool passwordVisible = false;
  bool? isRemember = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleLogin() async {
    var data = {
      "username": emailController.text,
      "password": passwordController.text,
    };

    final resp = await ApiService.loginUser(context, data);

    print(resp);

    if (resp != null) {
      T2BottomNavigation().launch(context, pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(appStore.appBarColor!);
    return Scaffold(
      body: Observer(
        builder: (_) => SingleChildScrollView(
          child: Container(
            color: context.scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                /*back icon*/
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    width: context.width(),
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                /*heading*/
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(t2_lbl_sign_in_header, maxLines: 2, style: boldTextStyle(size: 22, color: appStore.textPrimaryColor)),
                      SizedBox(width: 4),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          t1_lbl_sign_up,
                          maxLines: 2,
                          style: boldTextStyle(size: 18, color: appStore.textSecondaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                /*content*/
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(t2_hint_email, style: primaryTextStyle(size: 16)),
                      T2EditTextField(isPassword: false, isEmail: true, mController: emailController),
                      SizedBox(height: 25),
                      Text(t2_hint_password, style: primaryTextStyle(size: 16)),
                      T2EditTextField(isSecure: true, mController: passwordController,),
                      SizedBox(height: 18),
                      Row(
                        children: <Widget>[
                          CustomTheme(
                            child: Checkbox(
                              focusColor: t2_colorPrimary,
                              activeColor: t2_colorPrimary,
                              value: isRemember,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRemember = value;
                                });
                              },
                            ),
                          ),
                          Text(t2_lbl_remember, style: primaryTextStyle(size: 16, color: t2_textColorSecondary))
                        ],
                      ),
                      SizedBox(height: 18),
                      t2AppButton(
                        textContent: t2_lbl_sign_in,
                        onPressed: () {
                          _handleLogin();
                        },
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        child: Center(child: Text('Register', style: primaryTextStyle(color: t2_colorPrimary, size: 16))),
                        onTap: () {
                          T2SignUp().launch(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
