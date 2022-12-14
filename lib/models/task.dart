import 'package:hive/hive.dart';
import 'package:lista/models/category.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String taskName;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  String category;
  @HiveField(4)
  String date;

  Task({
    required this.taskName,
    this.isDone = false,
    required this.category,
    required this.date,
  }) : id = const Uuid().v4();

  void toggleDone() {
    isDone = !isDone;
  }

  void editTaskName(String newName) {
    taskName = newName;
  }

  void editTaskDate(String newDate) {
    date = newDate;
  }

  void editTaskCategory(String newCategory) {
    category = newCategory;
  }
}
