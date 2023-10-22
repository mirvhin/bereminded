import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/gql_client.dart';
import 'package:flutter_app/commands/create_reminder_cmd.dart';
import 'package:flutter_app/commands/update_reminder_cmd.dart';
import 'package:flutter_app/models/reminder.dart';
import 'package:flutter_app/util/log.dart';
import 'package:graphql/client.dart';

class ReminderApi extends API {
  final GQLClient _gql = GQLClient();

  Future<List<Reminder>> listReminders() async {
    final client = await _gql.auth();
    final result = await client.query(
      QueryOptions(
        document: gql("""
              query {
                getAllReminders {
                  id,
                  title,
                  description,
                  isDone,
                  created,
                  updated
                }
              }
            """),
      ),
    );

    handle(result);

    List<Reminder> reminders = (result.data!['getAllReminders'] as List<dynamic>)
        .map(
          (i) => Reminder.fromJson(i),
        )
        .toList();
    return reminders;
  }

  Future<Reminder> getReminder(String id) async {
    final client = await _gql.auth();
    final result = await client.query(
      QueryOptions(
        document: gql("""
              query {
                getReminder(id: "$id") {
                  id,
                  title,
                  description,
                  isDone,
                  created,
                  updated
                }
              }
            """),
      ),
    );

    handle(result);

    return Reminder.fromJson(result.data!['getReminder']);
  }

  Future<void> createReminder(CreateReminderCmd cmd) async {
    final client = await _gql.auth();
    final result = await client.mutate(
      MutationOptions(
        document: gql("""
              mutation {
                addReminder(addReminderInput: {
                  title: "${cmd.title}",
                  description: "${cmd.description}",
                  isDone: false,
                }) {
                  id,
                  title,
                  description,
                  isDone,
                  created,
                  updated
                }
              }
            """),
      ),
    );

    handle(result);
  }

  Future<void> updateReminder(UpdateReminderCmd cmd) async {
    final client = await _gql.auth();
    final result = await client.mutate(
      MutationOptions(
        document: gql("""
              mutation {
                updateReminder(updateReminderInput: {
                  id: "${cmd.id}",
                  title: "${cmd.title}",
                  description: "${cmd.description}",
                  isDone: ${cmd.isDone}
                }) {
                  id,
                  title,
                  description,
                  isDone,
                  created,
                  updated
                }
              }
            """),
      ),
    );

    handle(result);
  }
}
