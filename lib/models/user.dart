// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.online,
    this.email,
    this.name,
    this.uid,
  });

  bool online;
  String email;
  String name;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"],
        email: json["email"],
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "email": email,
        "name": name,
        "uid": uid,
      };
}
