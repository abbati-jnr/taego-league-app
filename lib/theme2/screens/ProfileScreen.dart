import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Images.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../helpers/shared_preference_services.dart';
import 'T2Walkthrough.dart';

class ProfileScreen extends StatefulWidget {
  static var tag = "/ProfileScreen";

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String? _selectedLocation = 'Male';
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = t2_user_name;
    addressController.text = t2_profile_address;
    contactController.text = t2_profile_contactNo;
    emailController.text = t2_user_email;
  }

  _handleLogout() async {
    // final resp = await ApiServices.logout(context);

    // if (resp != null) {
    //   await SharedPrefServices.removekey(key: 'token');
    //   toasty(context, 'Logged Out');
    //   LoginScreen().launch(context, isNewTask: true);
    // }

    await SharedPrefServices.removekey(key: 'token');
    toasty(context, 'Logged Out');
    T2WalkThrough().launch(context, isNewTask: true);

  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    var height = context.height();

    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) => Stack(
            children: <Widget>[
              CachedNetworkImage(
                placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                imageUrl: 'https://t4.ftcdn.net/jpg/01/85/84/73/360_F_185847357_Ad0Zt64iaUYy2p2ayrOeVc3fpvJixi5x.jpg',
                width: width,
                height: height / 2.5,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: height / 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Taego', style: primaryTextStyle(color: white)),
                          SizedBox(width: 20)
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: width,
                        decoration: BoxDecoration(color: t2_colorPrimary, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 16),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: CachedNetworkImage(placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?, imageUrl: userStore.user!.profilePic, width: 80, height: 80),
                                        ),
                                        SizedBox(width: 24),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('${userStore.user!.firstName} ${userStore.user!.lastName}', style: boldTextStyle(color: white, size: 16)),
                                              SizedBox(height: 8),
                                              Text(userStore.user!.email, style: primaryTextStyle(color: t2_white, size: 16)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          finish(context);
                                        },
                                        child: Icon(Icons.edit, color: t2TextColorPrimary),
                                        backgroundColor: t2_white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              decoration: BoxDecoration(color: context.scaffoldBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                              child: Container(
                                width: width,
                                height: height,
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AppButton(
                                      text: 'Logout',
                                      onTap: () => _handleLogout(),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: context.width(),
                height: 60,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Center(
                        child: Text(t2_lbl_profile, maxLines: 2, style: boldTextStyle(size: 22, color: t2_textColorPrimary)),
                      ),
                    )
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
