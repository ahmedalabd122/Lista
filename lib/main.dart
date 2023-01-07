import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista/models/categories_data.dart';
import 'package:lista/models/category.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';
import 'package:lista/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());

  Hive.registerAdapter(TaskAdapter());
  await Future.delayed(const Duration(microseconds: 500));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  CategoriesData categoriesData = CategoriesData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return TaskData();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CategoriesData();
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
