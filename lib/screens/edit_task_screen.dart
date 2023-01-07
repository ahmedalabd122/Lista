import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/models/categories_data.dart';
import 'package:lista/models/category.dart';
import 'package:provider/provider.dart';

import 'package:lista/data/theme.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';

class EditTaskScreen extends StatelessWidget {
  String? taskName;
  final int index;
  String category;

  EditTaskScreen({
    Key? key,
    required this.taskName,
    required this.index,
    required this.category,
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
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
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
                if (taskName != '' && category != '') {
                  final Task task = Task(
                    taskName: controller.text,
                    category: category,
                  );
                  Provider.of<TaskData>(context, listen: false)
                      .editTask(task, index);
                  Navigator.pop(context);
                } else if (taskName == '') {
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
                } else if (category == '') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CupertinoAlertDialog(
                        title: Text(
                          'please choose task category...',
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
            Column(
              children: [
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: AppColors.textColorLowEmphacy),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Icon(
                              CupertinoIcons.calendar,
                              color: AppColors.textColorLowEmphacy,
                            ),
                            Text('  Today '),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: AppColors.textColorLowEmphacy),
                      ),
                      child: ChangeNotifierProvider(
                        create: (context) => CategoriesData(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            items: Provider.of<CategoriesData>(context)
                                .categories
                                .map(buildMenuItem)
                                .toList(),
                            customButton: Icon(
                              CupertinoIcons.largecircle_fill_circle,
                              color: catColors[category],
                            ),
                            // Provider.of<CategoriesData>(context).color
                            onChanged: (value) {
                              category = value!;
                              Provider.of<CategoriesData>(context,
                                      listen: false)
                                  .setColor(catColors[category]!);
                            },
                            itemHeight: 48,
                            itemPadding:
                                const EdgeInsets.only(left: 16, right: 16),
                            dropdownWidth: 100,
                            dropdownPadding:
                                const EdgeInsets.symmetric(vertical: 6),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.secondaryColorSecondary,
                            ),
                            dropdownElevation: 8,
                            offset: const Offset(0, 8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Flex(
              direction: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(Category category) {
  return DropdownMenuItem(
      value: category.category,
      child: Text(
        category.category,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ));
}
