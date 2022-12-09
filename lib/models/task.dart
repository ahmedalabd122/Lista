class Task {
  final id;
  final String taskName;
  bool isDone;
  Task({
    required this.taskName,
    this.isDone = false,
    required this.id,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
