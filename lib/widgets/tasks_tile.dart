import 'package:flutter/material.dart';
import 'package:lista/widgets/lista_checkbox.dart';

class ListaTile extends StatelessWidget {
  final bool isChecked;
  final String taskTile;
  final Function(bool?)? checkBoxCallback;
  const ListaTile(
      {super.key,
      required this.isChecked,
      required this.taskTile,
      required this.checkBoxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTile,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: ListaCheckBox(
        checkBoxState: isChecked,
        toggleCheckboxState: checkBoxCallback,
      ),
    );
  }
}
