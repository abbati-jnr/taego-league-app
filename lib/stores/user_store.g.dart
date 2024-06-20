// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$userAtom = Atom(name: '_UserStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$usersAtom = Atom(name: '_UserStore.users', context: context);

  @override
  List<UserModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$getUsersAsyncAction =
      AsyncAction('_UserStore.getUsers', context: context);

  @override
  Future<dynamic> getUsers(BuildContext context) {
    return _$getUsersAsyncAction.run(() => super.getUsers(context));
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void setUser(dynamic resp) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setUser');
    try {
      return super.setUser(resp);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
users: ${users}
    ''';
  }
}
