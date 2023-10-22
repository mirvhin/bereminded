import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String username;
  String name;
  String accessToken;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "accessToken": accessToken,
      };
}
