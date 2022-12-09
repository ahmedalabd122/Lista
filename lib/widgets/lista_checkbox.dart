import 'package:flutter/material.dart';
import 'package:lista/widgets/tasks_tile.dart';

class ListaCheckBox extends StatelessWidget {
  final bool checkBoxState;
  final Function(bool?)? toggleCheckboxState;
  const ListaCheckBox({
    super.key,
    required this.checkBoxState,
    required this.toggleCheckboxState,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: const Color(0xff57d0a0),
      value: checkBoxState,
      onChanged: toggleCheckboxState,
    );
  }
}
