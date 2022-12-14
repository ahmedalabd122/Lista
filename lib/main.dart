import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista/models/task_data.dart';
import 'package:lista/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  //init hive flutter
  await Hive.initFlutter();
  // create a box
  var box = await Hive.openBox('tasksBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        // final _tasksBox = Hive.box('tasksBox');
        // if (_tasksBox.get('tasksBox') == null) {
        //   Provider.of<TaskData>(context).loadData();
        // } else {
        //   Provider.of<TaskData>(context).createInitialData();
        // }
        
        return TaskData();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
