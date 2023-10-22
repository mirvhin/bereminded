// ignore_for_file: use_build_context_synchronously, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_app/commands/update_reminder_cmd.dart';
import 'package:flutter_app/exceptions/api_gql_exception.dart';
import 'package:flutter_app/models/reminder.dart';
import 'package:flutter_app/pages/auth/list_reminders/list_reminders.dart';
import 'package:flutter_app/services/reminder_service.dart';
import 'package:flutter_app/util/loader.dart';
import 'package:flutter_app/util/log.dart';
import 'package:flutter_app/util/snackbar.dart';

class UpdateReminderPage extends StatefulWidget {
  static const String routeName = '/reminders/update';

  const UpdateReminderPage({super.key});

  @override
  State<UpdateReminderPage> createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ReminderService _service = ReminderService.instance;
  late Reminder? reminder = null;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      final id = arg as String;
      log("ID ==== $id");
      _getReminder(id);
    }
  }

  void _getReminder(String id) async {
    log("HELLO ------");
    var i = await _service.getReminder(id);

    setState(() {
      reminder = i;

      _isDone = reminder!.isDone;
      _description.text = reminder!.description;
      _title.text = reminder!.title;
    });
  }

  void _updateReminder() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoader(context);
        UpdateReminderCmd cmd = UpdateReminderCmd(
          reminder!.id,
          _title.text,
          _description.text,
          _isDone,
        );
        await _service.updateReminder(cmd);
        hideLoader(context);

        flash(context, "Successfully updated reminder!");
      } on APIGraphQLException catch (err) {
        hideLoader(context);
        flash(context, err.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: reminder == null
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ListRemindersPage.routeName);
                  },
                  child: const Text('Go Back to List Page'),
                ),
              ),
            )
          : Form(
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
                          'Update Reminder #${reminder!.id}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
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
                          readOnly: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: TextFormField(
                          controller: _description,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description is required";
                            }

                            return null;
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isDone = !_isDone;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Row(
                            children: <Widget>[
                              const Expanded(child: Text("Done?")),
                              Checkbox(
                                value: _isDone,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isDone = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
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
                                onPressed: _updateReminder,
                                child: const Text('Save Reminder'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ListRemindersPage.routeName);
                                },
                                child: const Text('Back to list'),
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
