// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String profilePic;
  int role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    profilePic: json["profile_pic"],
    role: json["role"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "profile_pic": profilePic,
    "role": role,
  };
}
