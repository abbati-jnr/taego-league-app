import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/theme2/screens/T2SignIn.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../services/api_services.dart';

class T2SignUp extends StatefulWidget {
  static var tag = "/T2SignUp";

  @override
  T2SignUpState createState() => T2SignUpState();
}

class T2SignUpState extends State<T2SignUp> {
  bool passwordVisible = false;
  bool isRemember = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> roles = ['Admin', 'Manager', 'Player'];
  String selectedRole = 'Admin';

  XFile? pickedImage;
  final ImagePicker picker = ImagePicker();
  String fileName = '', filePath = '';


  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  Future _getImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      fileName = pickedImage!.path.split('/').last;
      filePath = pickedImage!.path;
      setState(() {});
    }
  }

  void _handleRegister() async {
    var data = FormData.fromMap({
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": roles.indexOf(selectedRole) + 1,
      'profile_pic': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    final resp = await ApiService.registerUser(context, data);

    print(resp);

    if (resp != null) {
      snackBar(context, title: "Registration Successful");

      T2SignIn().launch(context, pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
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
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(color: t2_colorPrimary, shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: pickedImage != null ? Image.file(File(pickedImage!.path), height: 60, fit: BoxFit.cover): Icon(Icons.person, color: white, size: 60),
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
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Register', maxLines: 2, style: boldTextStyle(size: 22, color: appStore.textPrimaryColor)),
                  ],
                ),
              ),
              /*content*/
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Account type', style: primaryTextStyle(size: 16)),
                    Card(
                        elevation: 2,
                        child: DropdownButton(
                          isExpanded: true,
                          dropdownColor: appStore.appBarColor,
                          value: selectedRole,
                          style: boldTextStyle(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: appStore.iconColor,
                          ),
                          underline: 0.height,
                          onChanged: (dynamic newValue) {
                            setState(() {
                              selectedRole = newValue;
                            });
                          },
                          items: roles.map((category) {
                            return DropdownMenuItem(
                              child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                              value: category,
                            );
                          }).toList(),
                        )),
                    25.height,
                    Text('First name', style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, mController: firstNameController,),
                    SizedBox(height: 25),
                    Text('Last name', style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, mController: lastNameController,),
                    SizedBox(height: 25),
                    Text(t2_hint_email, style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, isEmail: true, mController: emailController,),
                    SizedBox(height: 25),
                    Text(t2_hint_password, style: primaryTextStyle(size: 16)),
                    T2EditTextField(isSecure: true, mController: passwordController),
                    SizedBox(height: 25),
                    Text(t2_hint_re_password, style: primaryTextStyle(size: 16)),
                    T2EditTextField(isSecure: true),
                    SizedBox(height: 50),
                    t2AppButton(
                        textContent: 'Register',
                        onPressed: () {
                          _handleRegister();
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
