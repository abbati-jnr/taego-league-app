import 'package:taego_league_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/fixture_model.dart';

part 'fixture_store.g.dart';


class FixtureStore = _FixtureStore with _$FixtureStore;

abstract class _FixtureStore with Store {
  @observable
  List<FixtureModel> fixtures = [];

  @action
  Future getFixtures(BuildContext context) async {
    final resp = await ApiService.getFixtures(context);
    if (resp != null) {
      fixtures = List<FixtureModel>.from(resp.map((x) => FixtureModel.fromMap(x)));
    }

  }

}