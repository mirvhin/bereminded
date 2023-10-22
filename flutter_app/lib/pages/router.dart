import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth/create_reminder/create_reminder.dart';
import 'package:flutter_app/pages/auth/list_reminders/list_reminders.dart';
import 'package:flutter_app/pages/auth/register/register.dart';
import 'package:flutter_app/pages/auth/sign_in/sign_in.dart';
import 'package:flutter_app/pages/auth/update_reminder/update_reminder.dart';

class AppRouter {
  final Map<String, Widget Function(BuildContext)> _routes = {
    SignInPage.routeName: (ctx) => const SignInPage(),
    ListRemindersPage.routeName: (ctx) => const ListRemindersPage(),
    CreateReminderPage.routeName: (ctx) => const CreateReminderPage(),
    UpdateReminderPage.routeName: (ctx) => const UpdateReminderPage(),
    RegisterPage.routeName: (ctx) => const RegisterPage(),
  };

  Map<String, Widget Function(BuildContext)> get routes => _routes;
}
