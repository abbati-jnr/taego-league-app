// To parse this JSON data, do
//
//     final teamModel = teamModelFromMap(jsonString);

import 'dart:convert';

TeamModel teamModelFromMap(String str) => TeamModel.fromMap(json.decode(str));

String teamModelToMap(TeamModel data) => json.encode(data.toMap());

class TeamModel {
  int id;
  String name;
  String logo;
  // List<int> league;
  String description;
  int teamManager;
  List<int> players;

  TeamModel({
    required this.id,
    required this.name,
    required this.logo,
    // required this.league,
    required this.description,
    required this.teamManager,
    required this.players,
  });

  factory TeamModel.fromMap(Map<String, dynamic> json) => TeamModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    // league: List<int>.from(json["league"].map((x) => x)),
    description: json["description"],
    teamManager: json["team_manager"],
    players: List<int>.from(json["players"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "logo": logo,
    // "league": List<dynamic>.from(league.map((x) => x)),
    "description": description,
    "team_manager": teamManager,
    "players": List<dynamic>.from(players.map((x) => x)),
  };
}
