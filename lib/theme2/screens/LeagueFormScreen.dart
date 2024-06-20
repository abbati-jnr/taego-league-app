import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/models/league_model.dart';
import 'package:taego_league_app/theme2/screens/LeagueScreen.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../services/api_services.dart';

class LeagueFormScreen extends StatefulWidget {
  final LeagueModel? league;
  static var tag = "/LeagueFormScreen";

  const LeagueFormScreen({Key? key, this.league}) : super(key: key);

  @override
  LeagueFormScreenState createState() => LeagueFormScreenState();
}

class LeagueFormScreenState extends State<LeagueFormScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  XFile? pickedImage;
  final ImagePicker picker = ImagePicker();
  String fileName = '', filePath = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    if (mounted) {
      if (widget.league != null) {
        nameController.text = widget.league!.name;
        descriptionController.text = widget.league!.description;
      }
    }
  }

  Future _getImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      fileName = pickedImage!.path.split('/').last;
      filePath = pickedImage!.path;
      setState(() {});
    }
  }

  _update() async {
    var resp;
    var formData = FormData.fromMap({
      'id': widget.league!.id,
      'name': nameController.text,
      'description': descriptionController.text,
      'admin': userStore.user!.id,
      // 'teams': [],
      if (pickedImage != null)
        'logo': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    resp = await ApiService.updateLeague(context, widget.league!.id, formData);
    if (resp != null) {
      snackBar(context, title: "League Update");

      leagueStore.getLeagues(context);

      finish(context);
    }
  }

  _submit() async {
    var resp;

    var formData = FormData.fromMap({
      'name': nameController.text,
      'description': descriptionController.text,
      'admin': userStore.user!.id,
      // 'teams': [],
      'logo': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    resp = await ApiService.postLeague(context, formData);

    if (resp != null) {
      snackBar(context, title: "League Created");

      leagueStore.getLeagues(context);

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
                    Text('Create League', maxLines: 2, style: boldTextStyle(size: 22, color: appStore.textPrimaryColor)),
                  ],
                ),
              ),
              /*content*/
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(color: t2_colorPrimary, shape: BoxShape.circle),
                          clipBehavior: Clip.antiAlias,
                          child: pickedImage != null ? Image.file(File(pickedImage!.path), height: 60, fit: BoxFit.cover)
                              : widget.league != null ? CachedNetworkImage(
                              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                              imageUrl: widget.league!.logo,
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill)
                              : Icon(Icons.person, color: white, size: 60),
                        ).onTap(
                                () async {
                              await _getImage();
                            }
                        ),
                        Positioned(
                          bottom: 16,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.edit, color: Colors.white, size: 20),
                            decoration: BoxDecoration(color: textSecondaryColor, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ).center(),
                    SizedBox(height: 25),
                    Text('Name', style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, mController: nameController,),
                    SizedBox(height: 25),
                    Text('Description', style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, mController: descriptionController,),
                    SizedBox(height: 50),
                    t2AppButton(
                        textContent: widget.league != null ? 'Update' : 'Submit',
                        onPressed: () {
                          if (widget.league != null) {
                            _update();
                          } else{
                            _submit();
                          }

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
