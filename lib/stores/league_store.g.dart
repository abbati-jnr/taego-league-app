// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LeagueStore on _LeagueStore, Store {
  late final _$leaguesAtom =
      Atom(name: '_LeagueStore.leagues', context: context);

  @override
  List<LeagueModel> get leagues {
    _$leaguesAtom.reportRead();
    return super.leagues;
  }

  @override
  set leagues(List<LeagueModel> value) {
    _$leaguesAtom.reportWrite(value, super.leagues, () {
      super.leagues = value;
    });
  }

  late final _$getLeaguesAsyncAction =
      AsyncAction('_LeagueStore.getLeagues', context: context);

  @override
  Future<dynamic> getLeagues(BuildContext context) {
    return _$getLeaguesAsyncAction.run(() => super.getLeagues(context));
  }

  @override
  String toString() {
    return '''
leagues: ${leagues}
    ''';
  }
}
