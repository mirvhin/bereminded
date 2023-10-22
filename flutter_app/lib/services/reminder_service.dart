import 'package:flutter_app/api/reminder_api.dart';
import 'package:flutter_app/commands/create_reminder_cmd.dart';
import 'package:flutter_app/commands/update_reminder_cmd.dart';
import 'package:flutter_app/models/reminder.dart';

class ReminderService {
  static final ReminderService instance = ReminderService._internal();

  factory ReminderService() {
    return instance;
  }

  ReminderService._internal();

  final ReminderApi _api = ReminderApi();

  Future<List<Reminder>> listReminders() async {
    return _api.listReminders();
  }

  Future<Reminder> getReminder(String id) async {
    return _api.getReminder(id);
  }

  Future<void> createReminder(CreateReminderCmd cmd) async {
    return _api.createReminder(cmd);
  }

  Future<void> updateReminder(UpdateReminderCmd cmd) async {
    return _api.updateReminder(cmd);
  }
}
