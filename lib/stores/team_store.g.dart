// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TeamStore on _TeamStore, Store {
  late final _$teamsAtom = Atom(name: '_TeamStore.teams', context: context);

  @override
  List<TeamModel> get teams {
    _$teamsAtom.reportRead();
    return super.teams;
  }

  @override
  set teams(List<TeamModel> value) {
    _$teamsAtom.reportWrite(value, super.teams, () {
      super.teams = value;
    });
  }

  late final _$getTeamsAsyncAction =
      AsyncAction('_TeamStore.getTeams', context: context);

  @override
  Future<dynamic> getTeams(BuildContext context) {
    return _$getTeamsAsyncAction.run(() => super.getTeams(context));
  }

  @override
  String toString() {
    return '''
teams: ${teams}
    ''';
  }
}
