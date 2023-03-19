import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/task.dart';
import 'package:lista/screens/add_task_screen.dart';
import 'package:lista/screens/edit_task_screen.dart';
import 'package:lista/widgets/lista_checkbox.dart';
import 'package:page_transition/page_transition.dart';

class ListaTile extends StatelessWidget {
  final Function(bool?)? checkBoxCallback;
  Task task;

  ListaTile({
    super.key,
    required this.task,
    required this.checkBoxCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ListaCheckBox(
        color: catColors[task.category],
        checkBoxState: task.isDone,
        toggleCheckboxState: checkBoxCallback,
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: EditTaskScreen(
                task: task,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            task.taskName,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorHighEmphacy,
            ),
          ),
        ),
      ),
    );
  }
}
