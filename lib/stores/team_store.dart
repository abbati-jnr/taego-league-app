import 'package:taego_league_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/team_model.dart';

part 'team_store.g.dart';


class TeamStore = _TeamStore with _$TeamStore;

abstract class _TeamStore with Store {
  @observable
  List<TeamModel> teams = [];

  @action
  Future getTeams(BuildContext context) async {
    final resp = await ApiService.getTeams(context);
    if (resp != null) {
      teams = List<TeamModel>.from(resp.map((x) => TeamModel.fromMap(x)));
    }

  }

}