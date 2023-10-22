class UpdateReminderCmd {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  UpdateReminderCmd(this.id, this.title, this.description,  this.isDone);
}
