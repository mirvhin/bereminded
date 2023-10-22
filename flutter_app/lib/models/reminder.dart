// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Reminder reminderFromJson(String str) => Reminder.fromJson(json.decode(str));

String reminderToJson(Reminder data) => json.encode(data.toJson());

class Reminder {
  String id;
  String title;
  String description;
  bool isDone;
  String created;
  String updated;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.created,
    required this.updated,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"],
        created: json["created"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isDone": isDone,
        "created": created,
        "updated": updated,
      };
}
