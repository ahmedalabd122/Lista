import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/categories_data.dart';
import 'package:lista/models/category.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';
import 'package:lista/widgets/catigory_selector.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskName = '';

  String category = '';

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 30),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AppColors.backgroundCard,
              offset: Offset(0, 0), //(x,y)
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: CupertinoButton(
            alignment: Alignment.center,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            //minSize: 70,
            color: AppColors.secondaryColorSecondary,
            child: const Text('New Task'),
            onPressed: () {
              if (newTaskName != '' && category != '') {
                final Task task = Task(
                  taskName: newTaskName,
                  category: category,
                  date: selectedDate.toString(),
                );
                Provider.of<TaskData>(context, listen: false).addTask(task);
                Navigator.pop(context);
              } else if (newTaskName == '') {
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
                padding: EdgeInsets.only(top: 60),
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
                    onChanged: (newText) {
                      newTaskName = newText;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: AppColors.textColorLowEmphacy),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.calendar,
                              color: CatigorySelector != ''
                                  ? catColors[category]
                                  : Colors.blue,
                            ),
                            Text(
                                '  ${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year} '),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: category != ''
                                      ? catColors[category]
                                      : Colors.blue,
                                ),
                                height: 200,
                                width: 300,
                                child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime.now(),
                                    minimumDate: DateTime(2022),
                                    maximumDate: DateTime(3000),
                                    onDateTimeChanged: (date) {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    }),
                              ),
                            );
                          });
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.textColorLowEmphacy),
                    ),
                    child: ChangeNotifierProvider(
                      create: (context) => CategoriesData(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          items: Provider.of<CategoriesData>(context)
                              .categories
                              .map(buildMenuItem)
                              .toList(),
                          customButton: Row(
                            children: [
                              Icon(
                                CupertinoIcons.largecircle_fill_circle,
                                color: category != ''
                                    ? catColors[category]
                                    : Colors.blue,
                              ),
                              Text(
                                category != '' ? ' $category' : ' category',
                                style: TextStyle(
                                  color: category != ''
                                      ? catColors[category]
                                      : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          onChanged: (value) {
                            setState(() {
                              category = value!;
                              Provider.of<CategoriesData>(context,
                                      listen: false)
                                  .setColor(catColors[category]!);
                            });
                          },
                          itemHeight: 48,
                          itemPadding:
                              const EdgeInsets.only(left: 16, right: 16),
                          dropdownWidth: 100,
                          dropdownPadding:
                              const EdgeInsets.symmetric(vertical: 6),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: category != ''
                                ? catColors[category]
                                : Colors.blue,
                          ),
                          dropdownElevation: 8,
                          offset: const Offset(0, 8),
                        ),
                      ),
                    ),
                  ),
                  CatigorySelector(
                    category: category,
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
