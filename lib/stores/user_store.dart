import 'package:taego_league_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/user_model.dart';

part 'user_store.g.dart';


class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  UserModel? user;

  @observable
  List<UserModel> users = [];

  @action
  Future getUsers(BuildContext context) async {
    final resp = await ApiService.getUsers(context);
    if (resp != null) {
      users = List<UserModel>.from(resp.map((x) => UserModel.fromMap(x)));
    }

  }

  @action
  void setUser(resp) {
    user = UserModel.fromMap(resp);
  }

}