import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/models/fixture_model.dart';
import 'package:taego_league_app/models/league_model.dart';
import 'package:taego_league_app/models/team_model.dart';
import 'package:taego_league_app/theme2/screens/FixtureScreen.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../services/api_services.dart';

class InvitationFormScreen extends StatefulWidget {
  final int teamId;
  static var tag = "/InvitationFormScreen";

  const InvitationFormScreen({Key? key, required this.teamId}) : super(key: key);

  @override
  InvitationFormScreenState createState() => InvitationFormScreenState();
}

class InvitationFormScreenState extends State<InvitationFormScreen> {
  var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await leagueStore.getLeagues(context);

  }

  _submit() async {
    var resp;

    var formData = FormData.fromMap({
      'email': emailController.text,
      'team': widget.teamId,
    });
    resp = await ApiService.postPlayerInvitation(context, formData);

    if (resp != null) {
      snackBar(context, title: "Invitation sent");

      finish(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  color: context.scaffoldBackgroundColor,
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
                    Text('Invite Player', maxLines: 2, style: boldTextStyle(size: 22, color: appStore.textPrimaryColor)),
                  ],
                ),
              ),
              /*content*/
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Email', style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, isEmail: true, mController: emailController,),
                    SizedBox(height: 50),
                    t2AppButton(
                        textContent: 'Submit',
                        onPressed: () {
                          _submit();

                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
