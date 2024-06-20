import 'package:taego_league_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/league_model.dart';

part 'league_store.g.dart';


class LeagueStore = _LeagueStore with _$LeagueStore;

abstract class _LeagueStore with Store {
  @observable
  List<LeagueModel> leagues = [];

  @action
  Future getLeagues(BuildContext context) async {
    final resp = await ApiService.getLeagues(context);
    if (resp != null) {
      leagues = List<LeagueModel>.from(resp.map((x) => LeagueModel.fromMap(x)));
    }

  }

}