// ignore_for_file: prefer_final_fields

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista/models/category.dart';

import 'task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  final String taskHiveBox = 'task-box';

  TaskData() {
    getItems();
  }

  void getItems() async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    if (box.isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      if (_tasks.isEmpty) {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: false,
            category: 'personal',
          ),
        ];
      } else if (_tasks.first.isDone == true) {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: true,
            category: 'personal',
          ),
        ];
      } else {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: false,
            category: 'personal',
          ),
        ];
      }
    } else {
      _tasks = box.values.toList();
    }

    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(Task task) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    _tasks.add(task);
    await box.add(task);
    _tasks = box.values.toList();
    notifyListeners();
  }

  void updateTask(Task task, int index) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    task.toggleDone();
    if (box.isNotEmpty) await box.putAt(index, task);
    notifyListeners();
  }

  void editTask(Task task, int index) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    task.editTaskName(task.taskName);
    if (box.isNotEmpty) await box.putAt(index, task);
    getItems();
  }

  void deleteTask(Task task, int index) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    _tasks.remove(task);
    if (box.isNotEmpty) {
      await box.deleteAt(index);
      getItems();
    } else {
      getItems();
    }
  }

  UnmodifiableListView<Task> getTasksByCategory(String category) {
    List<Task> _gTBC = [];
    _gTBC.addAll(_tasks);

    _gTBC.retainWhere((taskOne) => taskOne.category == category);
    return UnmodifiableListView(_gTBC);
  }

  List<Task> getDoneTasksByCategory(String category) {
    List<Task> gTBC = [];
    gTBC.addAll(_tasks);

    gTBC.retainWhere(
        (taskOne) => taskOne.category == category && taskOne.isDone == true);
    return gTBC;
  }

  void deleteAllData() async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    await box.clear();
    _tasks = box.values.toList();
    getItems();
  }
}
