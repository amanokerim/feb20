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

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      time: map["time"],
      title: map["title"],
      status: map["status"],
    );
  }
}
