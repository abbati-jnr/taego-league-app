import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taego_league_app/main.dart';
import 'package:taego_league_app/main/utils/AppWidget.dart';
import 'package:taego_league_app/models/team_model.dart';
import 'package:taego_league_app/models/user_model.dart';
import 'package:taego_league_app/theme2/screens/TeamScreen.dart';
import 'package:taego_league_app/theme2/utils/T2Colors.dart';
import 'package:taego_league_app/theme2/utils/T2Strings.dart';
import 'package:taego_league_app/theme2/utils/T2Widgets.dart';

import '../../models/league_model.dart';
import '../../services/api_services.dart';

class TeamFormScreen extends StatefulWidget {
  final TeamModel? team;
  static var tag = "/TeamFormScreen";

  const TeamFormScreen({Key? key, this.team}) : super(key: key);

  @override
  TeamFormScreenState createState() => TeamFormScreenState();
}

class TeamFormScreenState extends State<TeamFormScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  List<UserModel> selectedPlayers = [];

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
      if (widget.team != null) {
        nameController.text = widget.team!.name;
        descriptionController.text = widget.team!.description;
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
      'id': widget.team!.id,
      'name': nameController.text,
      'description': descriptionController.text,
      'team_manager': userStore.user!.id,
      // 'teams': [],
      if (pickedImage != null)
        'logo': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    resp = await ApiService.updateTeam(context, widget.team!.id, formData);
    if (resp != null) {
      snackBar(context, title: "Team Update");

      teamStore.getTeams(context);

      finish(context);
    }
  }

  _submit() async {
    var resp;

    var formData = FormData.fromMap({
      'name': nameController.text,
      'description': descriptionController.text,
      'team_manager': userStore.user!.id,
      'players': selectedPlayers,
      'logo': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    resp = await ApiService.postTeam(context, formData);

    if (resp != null) {
      snackBar(context, title: "Team Created");

      teamStore.getTeams(context);

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
                    Text('Create Team', maxLines: 2, style: boldTextStyle(size: 22, color: appStore.textPrimaryColor)),
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
                              : widget.team != null ? CachedNetworkImage(
                              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                              imageUrl: widget.team!.logo,
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
                    // 24.height,
                    // Text('Players', style: primaryTextStyle(size: 16)),
                    // 16.height,
                    // DropdownSearch<UserModel>(
                    //   popupProps: PopupProps.dialog(
                    //     // showSelectedItems: true,
                    //     showSearchBox: true,
                    //     dialogProps: DialogProps(
                    //         contentPadding: EdgeInsets.all(8),
                    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                    //     ),
                    //     searchFieldProps: TextFieldProps(
                    //         decoration: waInputDecoration(
                    //             hint: 'Search players'
                    //         )
                    //     ),
                    //     disabledItemFn: (Union u) => u.name.startsWith('Abuja'),
                    //   ),
                    //   dropdownDecoratorProps: DropDownDecoratorProps(
                    //     dropdownSearchDecoration: waInputDecoration(
                    //       hint: "select operator\'s union",
                    //     ),
                    //   ),
                    //   items: unionStore.unions,
                    //   itemAsString: (Union u) => u.name,
                    //   onChanged: (u) {
                    //     setState(() {
                    //       selectedUnion = u;
                    //     });
                    //   },
                    //   selectedItem: selectedUnion,
                    //   dropdownBuilder: (BuildContext context, selectedItem) {
                    //     return Text(
                    //       selectedItem == null ? 'Select Union' : selectedItem.name,
                    //     );
                    //   },
                    // ),
                    SizedBox(height: 50),
                    t2AppButton(
                        textContent: widget.team != null ? 'Update' : 'Submit',
                        onPressed: () {
                          if (widget.team != null) {
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
