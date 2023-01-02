import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lista/data/theme.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';

class EditTaskScreen extends StatelessWidget {
  String? taskName;
  final int index;
  EditTaskScreen({
    Key? key,
    required this.taskName,
    required this.index,
  }) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = taskName!;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
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
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              minSize: 70,
              color: AppColors.secondaryColorSecondary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Edit Task  '),
                  Icon(
                    CupertinoIcons.chevron_up,
                  ),
                ],
              ),
              onPressed: () {
                if (taskName != '') {
                  final Task task = Task(
                    taskName: controller.text,
                  );
                  Provider.of<TaskData>(context, listen: false)
                      .editTask(task, index);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CupertinoAlertDialog(
                        title: Text(
                          'please enter your task name...',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  );
                }
              }),
        ),
        drawerScrimColor: Colors.white,
        backgroundColor: AppColors.backgroundWhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.textColorLowEmphacy),
                    ),
                    child: const Icon(
                      CupertinoIcons.xmark,
                      color: AppColors.backgroundCard,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: CupertinoTextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                  minLines: 1,
                  maxLines: 6,
                  autofocus: true,
                  placeholder: 'Add a new Task here...',
                  placeholderStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.placeholderText,
                    fontSize: 32,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                  cursorHeight: 32,
                  cursorWidth: 3,
                ),
              ),
            ),
            Flex(direction: Axis.vertical),
          ],
        ),
      ),
    );
  }
}
