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
            date: DateTime.now().toString(),
          ),
        ];
      } else if (_tasks.first.isDone == true) {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: true,
            category: 'personal',
            date: DateTime.now().toString(),
          ),
        ];
      } else {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: false,
            category: 'personal',
            date: DateTime.now().toString(),
          ),
        ];
      }
    } else {
      _tasks = box.values.toList();
      sortByDate();
    }

    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(Task task) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    await box.add(task);
    _tasks = box.values.toList();
    sortByDate();
    notifyListeners();
  }

  void updateTask(
    Task task,
  ) async {
    task.toggleDone();
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    dynamic k = box.keys.firstWhere((element) => box.get(element) == task);
    if (box.isNotEmpty) {
      await box.put(k, task);
    }
    notifyListeners();
  }

  int getIndexById(String id) {
    int index = 0;
    index = _tasks.indexWhere((element) => element.id == id);
    debugPrint('$index');
    return index;
  }

  void editTask(Task task) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);

    if (box.isNotEmpty) {
      dynamic k = await box.keys.firstWhere((element) {
        if (box.get(element)!.id == task.id) debugPrint('editTask');
        return box.get(element)!.id == task.id;
      });
      await box.put(k, task);
    } else {
      await box.add(task);
    }

    getItems();
  }

  Future deleteTask(int index) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    if (box.isNotEmpty) {
      await box.deleteAt(index);
      getItems();
    } else {
      getItems();
    }
  }

  Future deleteTaskFromCategory(String id) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    _tasks.removeWhere((task) => task.id == id);
    if (box.isNotEmpty) {
      _tasks.removeWhere((task) => task.id == id);
      await box.clear();
      box.addAll(_tasks);
      getItems();
    } else {
      getItems();
    }
  }

  Future deleteAllDataByCategory(String category) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    _tasks.retainWhere((taskOne) => taskOne.category != category);
    await box.clear();
    box.addAll(_tasks);
    getItems();
  }

  void getItemsByCat(String category) async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    if (box.isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      if (_tasks.isEmpty) {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: false,
            category: 'personal',
            date: DateTime.now().toString(),
          ),
        ];
      } else if (_tasks.first.isDone == true) {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: true,
            category: 'personal',
            date: DateTime.now().toString(),
          ),
        ];
      } else {
        _tasks = [
          Task(
            taskName: 'Add new Task below',
            isDone: false,
            category: 'personal',
            date: DateTime.now().toString(),
          ),
        ];
      }
    } else {
      getDoneTasksByCategory(category);
    }

    notifyListeners();
  }

  List<Task> _gTBC = [];

  UnmodifiableListView<Task> getTasksByCategory(String category) {
    _gTBC = [];
    _gTBC.addAll(_tasks);
    _gTBC.retainWhere((taskOne) => taskOne.category == category);
    return UnmodifiableListView(_gTBC);
  }

  List<Task> getDoneTasksByCategory(String category) {
    List<Task> gDTBC = [];
    gDTBC.addAll(_tasks);
    gDTBC.retainWhere(
        (taskOne) => taskOne.category == category && taskOne.isDone == true);

    return gDTBC;
  }

  void deleteAllData() async {
    Box<Task> box = await Hive.openBox<Task>(taskHiveBox);
    await box.clear();
    _tasks = box.values.toList();
    getItems();
  }

  void sortByDate() async {
    _tasks.sort((a, b) => a.date.compareTo(b.date));
  }
}
