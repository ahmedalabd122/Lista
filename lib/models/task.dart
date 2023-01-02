import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(2)
  String taskName;
  @HiveField(3)
  bool isDone;
  Task({
    required this.taskName,
    this.isDone = false,
  }) : id = const Uuid().v4();

  void toggleDone() {
    isDone = !isDone;
  }

  void editTaskName(String newName) {
    taskName = newName;
  }
}
