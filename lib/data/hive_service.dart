import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

import 'package:lista/models/task.dart';

class HiveService extends ChangeNotifier {
  List<Task> _tasks = [];
  UnmodifiableListView<Task> get notes => UnmodifiableListView(_tasks);
  final String noteHiveBox = 'note-box';
}
