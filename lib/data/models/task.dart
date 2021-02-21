class Task {
  int id;
  int time;
  String title;
  // 0 - in progress, 1 - completed, ...
  int status;

  Task({
    this.id,
    this.time,
    this.title,
    this.status,
  });
}
