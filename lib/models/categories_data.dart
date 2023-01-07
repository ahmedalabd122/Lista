import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista/data/theme.dart';
import 'category.dart';

class CategoriesData extends ChangeNotifier {
  List<Category> _tasksCategories = [];
  List<Category> get categories => _tasksCategories;
  final String categoryHiveBox = 'category-box';

  CategoriesData() {
    getItems();
  }
  Color color = Colors.blue;

  void setColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  void getItems() async {
    Box<Category> box = await Hive.openBox<Category>(categoryHiveBox);
    if (box.isEmpty) {
      await box.putAll(
        {
          0: Category(
            category: 'personal',
          ),
          1: Category(
            category: 'business',
          ),
        },
      );
      _tasksCategories = box.values.toList();
    } else {
      _tasksCategories = box.values.toList();
    }
    //print(_tasksCategories.first.category);
    notifyListeners();
  }

  void addCategory(Category category) async {
    Box<Category> box = await Hive.openBox<Category>(categoryHiveBox);
    _tasksCategories.add(category);
    await box.add(category);
    _tasksCategories = box.values.toList();
    notifyListeners();
  }

  Category getCategory(String category) {
    int index = 0;
    for (int i = 0; i < _tasksCategories.length; i++) {
      if (_tasksCategories[i].category == category) {
        index = i;
        break;
      }
    }
    notifyListeners();
    return _tasksCategories[index];
  }
}
