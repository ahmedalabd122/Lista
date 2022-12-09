import 'package:flutter/material.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newTaskName = '';
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Add New Task',
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff57d0a0),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              minLines: 1,
              maxLines: 6,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskName = newText;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final Task task = Task(
                    taskName: newTaskName,
                    id: Provider.of<TaskData>(context, listen: false)
                            .taskCount +
                        1);
                Provider.of<TaskData>(context, listen: false).addTask(task);
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
