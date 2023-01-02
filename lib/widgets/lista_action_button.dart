import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lista/data/theme.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';

class ListaActionButton extends StatelessWidget {
  ListaActionButton({
    Key? key,
    required this.text,
    required this.actionOnPress,
  }) : super(key: key);

  final String text;
  Function actionOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 235,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColors.secondaryColorSecondary,
            offset: Offset(3, 5.0), //(x,y)
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: CupertinoButton(
        alignment: Alignment.centerRight,
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        minSize: 70,
        color: AppColors.secondaryColorSecondary,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('New Task  '),
            Icon(
              CupertinoIcons.chevron_up,
            ),
          ],
        ),
        onPressed: () {
          actionOnPress;
          // if (text != '') {

          // } else {
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       return const CupertinoAlertDialog(
          //         title: Text(
          //           'please enter your task name...',
          //           style: TextStyle(
          //             fontSize: 14,
          //           ),
          //           textAlign: TextAlign.center,
          //         ),
          //       );
          //     },
          //   );
          // }
        },
      ),
    );
  }
}
