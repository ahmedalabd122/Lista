import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';

class ToDoDatabase {
  final _tasksBox = Hive.box('tasksBox');
  List<Task> _tasks = [];
  void checkInitiated() {
    if (_tasksBox.get('TODOLIST')) {
      createInitialData();
    } else {
      loadData();
    }
  }

  void createInitialData() {
    _tasks = [
      Task(taskName: 'Go on and add taskes to do it', id: 0),
    ];
  }

  void loadData() {
    _tasks = _tasksBox.get('TODOLIST');
  }

  List<Task> get tasksData {
    return _tasks;
  }

  void updateDataBase(List<Task> _tasks) {
    _tasksBox.put('TODOLIST', _tasks);
  }
}
