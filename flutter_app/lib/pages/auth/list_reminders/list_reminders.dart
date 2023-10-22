// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_app/models/reminder.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/pages/auth/create_reminder/create_reminder.dart';
import 'package:flutter_app/pages/auth/sign_in/sign_in.dart';
import 'package:flutter_app/pages/auth/update_reminder/update_reminder.dart';
import 'package:flutter_app/services/reminder_service.dart';
import 'package:flutter_app/services/storage_service.dart';

class ListRemindersPage extends StatefulWidget {
  static const String routeName = '/reminders/list';

  const ListRemindersPage({super.key});

  @override
  State<ListRemindersPage> createState() => _ListRemindersPageState();
}

class _ListRemindersPageState extends State<ListRemindersPage> {
  final StorageService _storage = StorageService.instance;
  final ReminderService _service = ReminderService.instance;
  late Future<User?> user;
  late Future<List<Reminder>> reminders;

  @override
  void initState() {
    reminders = _service.listReminders();
    user = _storage.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _storage.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SignInPage.routeName,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Sign Out',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: FutureBuilder<User?>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data != null
                          ? 'Welcome, ${snapshot.data!.name}'
                          : '',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateReminderPage.routeName);
                    },
                    child: const Text('Create New Reminder'),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Reminder>>(
              future: reminders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                'Title',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Description',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Date Created',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Status',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...snapshot.data!
                          .map(
                            (reminder) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  UpdateReminderPage.routeName,
                                  arguments: reminder.id,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(reminder.title,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                    Expanded(
                                      child: Text(reminder.description,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                    Expanded(
                                      child: Text(reminder.created,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                    Expanded(
                                      child: Text(reminder.isDone ? 'DONE' : 'TODO',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                }

                return Text(
                  'Loading Reminders...',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
