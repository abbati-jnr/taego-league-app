// To parse this JSON data, do
//
//     final leagueModel = leagueModelFromMap(jsonString);

import 'dart:convert';

LeagueModel leagueModelFromMap(String str) => LeagueModel.fromMap(json.decode(str));

String leagueModelToMap(LeagueModel data) => json.encode(data.toMap());

class LeagueModel {
  int id;
  String name;
  String logo;
  String description;
  int admin;
  List<int> teams;

  LeagueModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.admin,
    required this.teams,
  });

  factory LeagueModel.fromMap(Map<String, dynamic> json) => LeagueModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    admin: json["admin"],
    teams: List<int>.from(json["teams"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "logo": logo,
    "description": description,
    "admin": admin,
    "teams": List<dynamic>.from(teams.map((x) => x)),
  };
}
