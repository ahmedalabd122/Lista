import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/task.dart';
import 'package:lista/screens/add_task_screen.dart';
import 'package:lista/screens/edit_task_screen.dart';
import 'package:lista/widgets/lista_checkbox.dart';
import 'package:page_transition/page_transition.dart';

class ListaTile extends StatelessWidget {
  final bool isChecked;
  final String taskTile;
  final Function(bool?)? checkBoxCallback;
  final int index;
  const ListaTile({
    super.key,
    required this.isChecked,
    required this.taskTile,
    required this.checkBoxCallback,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ListaCheckBox(
        checkBoxState: isChecked,
        toggleCheckboxState: checkBoxCallback,
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: EditTaskScreen(
                index: index,
                taskName: taskTile,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            taskTile,
            style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
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
