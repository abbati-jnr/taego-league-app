// To parse this JSON data, do
//
//     final fixtureModel = fixtureModelFromMap(jsonString);

import 'dart:convert';

import 'package:taego_league_app/models/league_model.dart';
import 'package:taego_league_app/models/team_model.dart';

FixtureModel fixtureModelFromMap(String str) => FixtureModel.fromMap(json.decode(str));

String fixtureModelToMap(FixtureModel data) => json.encode(data.toMap());

class FixtureModel {
  int id;
  LeagueModel league;
  TeamModel team1;
  TeamModel team2;
  DateTime date;
  String time;
  String location;

  FixtureModel({
    required this.id,
    required this.league,
    required this.team1,
    required this.team2,
    required this.date,
    required this.time,
    required this.location,
  });

  factory FixtureModel.fromMap(Map<String, dynamic> json) => FixtureModel(
    id: json["id"],
    league: LeagueModel.fromMap(json["league"]),
    team1: TeamModel.fromMap(json["team1"]),
    team2: TeamModel.fromMap(json["team2"]),
    date: DateTime.parse(json["date"]),
    time: json["time"],
    location: json["location"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "league": league.toMap(),
    "team1": team1.toMap(),
    "team2": team2.toMap(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "location": location,
  };
}

