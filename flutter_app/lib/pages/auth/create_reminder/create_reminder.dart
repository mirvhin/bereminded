// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/commands/create_reminder_cmd.dart';
import 'package:flutter_app/exceptions/api_gql_exception.dart';
import 'package:flutter_app/pages/auth/list_reminders/list_reminders.dart';
import 'package:flutter_app/services/reminder_service.dart';
import 'package:flutter_app/util/loader.dart';
import 'package:flutter_app/util/snackbar.dart';

class CreateReminderPage extends StatefulWidget {
  static const String routeName = '/reminders/create';

  const CreateReminderPage({super.key});

  @override
  State<CreateReminderPage> createState() => _CreateReminderPageState();
}

class _CreateReminderPageState extends State<CreateReminderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ReminderService _service = ReminderService.instance;

  void _createReminder() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoader(context);
        CreateReminderCmd cmd = CreateReminderCmd(
            _title.text, _description.text);
        await _service.createReminder(cmd);
        hideLoader(context);

        flash(context, "Successfully created a new Reminder!");

        _formKey.currentState!.reset();

        Navigator.pushNamed(context, ListRemindersPage.routeName);
      } on APIGraphQLException catch (err) {
        hideLoader(context);
        flash(context, err.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Text(
                    'Create a New Reminder',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    controller: _title,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Title is required";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: TextFormField(
                    maxLines: 3,
                    controller: _description,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Description is required";

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _createReminder,
                          child: const Text('Save Reminder'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
