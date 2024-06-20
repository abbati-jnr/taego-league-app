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

class FixtureFormScreen extends StatefulWidget {
  final FixtureModel? fixture;
  static var tag = "/FixtureFormScreen";

  const FixtureFormScreen({Key? key, this.fixture}) : super(key: key);

  @override
  FixtureFormScreenState createState() => FixtureFormScreenState();
}

class FixtureFormScreenState extends State<FixtureFormScreen> {
  var locationController = TextEditingController();
  var descriptionController = TextEditingController();

  LeagueModel? selectedLeague;
  TeamModel? selectedTeamA;
  TeamModel? selectedTeamB;

  DateTime date = DateTime.timestamp();
  DateTime time = DateTime.timestamp();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await leagueStore.getLeagues(context);

    if (mounted) {
      if (widget.fixture != null) {
        locationController.text = widget.fixture!.location;
      }
    }
  }

  _update() async {
    var resp;
    var formData = FormData.fromMap({
      'id': widget.fixture!.id,
      'name': locationController.text,
      'description': descriptionController.text,
      'admin': userStore.user!.id,

    });
    resp = await ApiService.updateFixture(context, widget.fixture!.id, formData);
    if (resp != null) {
      snackBar(context, title: "Fixture Update");

      fixtureStore.getFixtures(context);

      finish(context);
    }
  }

  _submit() async {
    var resp;
    print("${time.hour.toString()}:${time.minute.toString().padLeft(2, '0')}");

    var formData = FormData.fromMap({
      'location': locationController.text,
      'team1_id': selectedTeamA!.id,
      'team2_id': selectedTeamB!.id,
      'league_id': selectedLeague!.id,
      'date': "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      'time': "${time.hour.toString()}:${time.minute.toString().padLeft(2, '0')}",
    });
    resp = await ApiService.postFixture(context, formData);

    if (resp != null) {
      snackBar(context, title: "Fixture Created");

      fixtureStore.getFixtures(context);

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
                    Text('Create Fixture', maxLines: 2, style: boldTextStyle(size: 22, color: appStore.textPrimaryColor)),
                  ],
                ),
              ),
              /*content*/
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Location', style: primaryTextStyle(size: 16)),
                    T2EditTextField(isPassword: false, mController: locationController,),
                    SizedBox(height: 25),
                    Text('League', style: primaryTextStyle(size: 16)),
                    16.height,
                    DropdownSearch<LeagueModel>(
                      popupProps: PopupProps.dialog(
                        // showSelectedItems: true,
                        showSearchBox: true,
                        dialogProps: DialogProps(
                            contentPadding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                        ),
                        searchFieldProps: TextFieldProps(
                            decoration: waInputDecoration(
                                hint: 'Search League'
                            )
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: waInputDecoration(
                          hint: "select league",
                        ),
                      ),
                      items: leagueStore.leagues,
                      itemAsString: (LeagueModel league) => league.name,
                      onChanged: (value) {
                        setState(() {
                          selectedLeague = value;
                        });
                      },
                      selectedItem: selectedLeague,
                      dropdownBuilder: (BuildContext context, selectedItem) {
                        return Text(
                          selectedItem == null ? 'Select League' : selectedLeague!.name,
                        );
                      },
                    ),
                    24.height,
                    Text('Team A', style: primaryTextStyle(size: 16)),
                    16.height,
                    DropdownSearch<TeamModel>(
                      popupProps: PopupProps.dialog(
                        // showSelectedItems: true,
                        showSearchBox: true,
                        dialogProps: DialogProps(
                            contentPadding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                        ),
                        searchFieldProps: TextFieldProps(
                            decoration: waInputDecoration(
                                hint: 'Search Team'
                            )
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: waInputDecoration(
                          hint: "select team A",
                        ),
                      ),
                      items: teamStore.teams,
                      itemAsString: (TeamModel team) => team.name,
                      onChanged: (value) {
                        setState(() {
                          selectedTeamA = value;
                        });
                      },
                      selectedItem: selectedTeamA,
                      dropdownBuilder: (BuildContext context, selectedItem) {
                        return Text(
                          selectedItem == null ? 'Select team A' : selectedTeamA!.name,
                        );
                      },
                    ),
                    24.height,
                    Text('Team B', style: primaryTextStyle(size: 16)),
                    16.height,
                    DropdownSearch<TeamModel>(
                      popupProps: PopupProps.dialog(
                        // showSelectedItems: true,
                        showSearchBox: true,
                        dialogProps: DialogProps(
                            contentPadding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                        ),
                        searchFieldProps: TextFieldProps(
                            decoration: waInputDecoration(
                                hint: 'Search Team'
                            )
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: waInputDecoration(
                          hint: "select team A",
                        ),
                      ),
                      items: teamStore.teams,
                      itemAsString: (TeamModel team) => team.name,
                      onChanged: (value) {
                        setState(() {
                          selectedTeamB = value;
                        });
                      },
                      selectedItem: selectedTeamB,
                      dropdownBuilder: (BuildContext context, selectedItem) {
                        return Text(
                          selectedItem == null ? 'Select team B' : selectedTeamB!.name,
                        );
                      },
                    ),
                    24.height,
                    Text('Date', style: primaryTextStyle(size: 16)),
                    16.height,
                    AppTextField(
                      decoration: waInputDecoration(
                        hint: '${date.year.toString()}-${date.month.toString()}-${date.day.toString()}',
                      ),
                      onTap: () => showInDialog(
                          context,
                          builder: (_) => Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: date,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() {
                                      date = newDateTime;
                                    });
                                  },
                                ).expand(),
                                8.height,
                                TextButton(onPressed: () => finish(context), child: Text('Ok'))
                              ],
                            ),
                          )
                      ),
                      // readOnly: true,
                      textFieldType: TextFieldType.NUMBER,
                      keyboardType: TextInputType.none,
                      // controller: phoneNumberController,
                      // focus: phoneNumberFocusNode,
                    ),
                    24.height,
                    Text('Time', style: primaryTextStyle(size: 16)),
                    16.height,
                    AppTextField(
                      decoration: waInputDecoration(
                        hint: '${time.hour.toString()}-${time.minute.toString()}-00',
                      ),
                      onTap: () => showInDialog(
                          context,
                          builder: (_) => Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: time,
                                  onDateTimeChanged: (DateTime newTime) {
                                    setState(() {
                                      time = newTime;
                                    });
                                  },
                                ).expand(),
                                8.height,
                                TextButton(onPressed: () => finish(context), child: Text('Ok'))
                              ],
                            ),
                          )
                      ),
                      // readOnly: true,
                      textFieldType: TextFieldType.NUMBER,
                      keyboardType: TextInputType.none,
                      // controller: phoneNumberController,
                      // focus: phoneNumberFocusNode,
                    ),
                    // Text('Description', style: primaryTextStyle(size: 16)),
                    // T2EditTextField(isPassword: false, mController: descriptionController,),
                    SizedBox(height: 50),
                    t2AppButton(
                        textContent: widget.fixture != null ? 'Update' : 'Submit',
                        onPressed: () {
                          if (widget.fixture != null) {
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
