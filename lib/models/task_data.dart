// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista/data/database.dart';
import 'task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  final _tasksBox = Hive.box('tasksBox');
  List<Task> _tasks = [];

  // TaskData() {
  //   print('asdasd');
  //   if (_tasksBox.get('tasksBox')) {
  //     _tasks = _tasksBox.get('TODOLIST');
  //     notifyListeners();
  //   } else {
  //     createInitialData();
  //     _tasksBox.put('TODOLIST', _tasks);
  //     notifyListeners();
  //   }
  // }

  void createInitialData() {
    _tasks = [
      Task(taskName: 'Go on and add taskes to do it', id: 0),
    ];
    notifyListeners();
  }

  void loadData() {
    _tasks = _tasksBox.get('TODOLIST');
  }

  List<Task> get tasksData {
    return _tasks;
  }

  void updateDataBase(List<Task> _tasks) {
    _tasksBox.put('TODOLIST', _tasks);
    loadData();
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(Task task) {
    _tasks.add(task);
    updateDataBase(_tasks);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    updateDataBase(_tasks);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    updateDataBase(_tasks);
    notifyListeners();
  }
}
