// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FixtureStore on _FixtureStore, Store {
  late final _$fixturesAtom =
      Atom(name: '_FixtureStore.fixtures', context: context);

  @override
  List<FixtureModel> get fixtures {
    _$fixturesAtom.reportRead();
    return super.fixtures;
  }

  @override
  set fixtures(List<FixtureModel> value) {
    _$fixturesAtom.reportWrite(value, super.fixtures, () {
      super.fixtures = value;
    });
  }

  late final _$getFixturesAsyncAction =
      AsyncAction('_FixtureStore.getFixtures', context: context);

  @override
  Future<dynamic> getFixtures(BuildContext context) {
    return _$getFixturesAsyncAction.run(() => super.getFixtures(context));
  }

  @override
  String toString() {
    return '''
fixtures: ${fixtures}
    ''';
  }
}
