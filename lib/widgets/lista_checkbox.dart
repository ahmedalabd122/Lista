import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/categories_data.dart';
import 'package:lista/widgets/tasks_tile.dart';
import 'package:provider/provider.dart';

class ListaCheckBox extends StatelessWidget {
  final bool checkBoxState;
  final Function(bool?)? toggleCheckboxState;
  Color? color;
  ListaCheckBox({
    super.key,
    required this.checkBoxState,
    required this.toggleCheckboxState,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: color,
      ),
      child: Checkbox(
        shape: const CircleBorder(),
        activeColor: color,
        value: checkBoxState,
        onChanged: toggleCheckboxState,
      ),
    );
  }
}
