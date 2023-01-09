import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/task_data.dart';
import 'package:lista/screens/add_task_screen.dart';
import 'package:lista/widgets/catigory_list.dart';
import 'package:lista/widgets/tasks_list.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      backgroundColor: AppColors.backgroundWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: AddTaskScreen(),
            ),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.secondaryColorSecondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.backgroundWhite,
            size: 30,
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundWhite,
        // leading: const Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: Icon(
        //     CupertinoIcons.line_horizontal_3,
        //     size: 30,
        //     color: AppColors.backgroundCard,
        //   ),
        // ),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.only(left: 15),
          //   child: Icon(
          //     CupertinoIcons.search,
          //     size: 30,
          //     color: AppColors.backgroundCard,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   child: Icon(
          //     Icons.notifications,
          //     size: 30,
          //     color: AppColors.backgroundCard,
          //   ),
          // ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'What\'s up!',
              style: TextStyle(
                color: AppColors.backgroundDark,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              'CATEGORIES',
              style: TextStyle(
                color: Color.fromARGB(146, 9, 32, 51),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(
            child: CatigoryList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 0),
                child: Text(
                  'TODAY\'S TASKS',
                  style: TextStyle(
                    color: Color.fromARGB(146, 9, 32, 51),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (Provider.of<TaskData>(context).taskCount > 1)
                    CupertinoButton(
                      child: const Text(
                        'Delete all',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: ((context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                'Do you want to delete all tasks?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    Provider.of<TaskData>(context,
                                            listen: false)
                                        .deleteAllData();
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          }),
                        );
                      },
                    ),
                  if (Provider.of<TaskData>(context).taskCount <= 1)
                    const SizedBox(
                      height: 50,
                    ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
              ),
              child: ListaListView(),
            ),
          ),
        ],
      ),
    );
  }
}
