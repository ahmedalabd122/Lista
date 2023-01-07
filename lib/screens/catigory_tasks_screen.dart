import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/task_data.dart';
import 'package:lista/widgets/tasks_list.dart';
import 'package:lista/widgets/tasks_tile.dart';
import 'package:provider/provider.dart';

class CatigoryTasksScreen extends StatelessWidget {
  CatigoryTasksScreen({super.key, required this.category});
  AudioPlayer audio = AudioPlayer(playerId: '1');
  AudioPlayer audio2 = AudioPlayer(playerId: '2');
  String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundWhite,
        foregroundColor: AppColors.backgroundCard,
      ),
      body: Container(
        color: AppColors.backgroundWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Text(
                category,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Text(
                    '${Provider.of<TaskData>(context).getTasksByCategory(category).length} tasks',
                    style: const TextStyle(
                      color: Color.fromARGB(146, 9, 32, 51),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
                // if (Provider.of<TaskData>(context)
                //         .getTasksByCategory(category)
                //         .length >
                //     1)
                //   CupertinoButton(
                //     child: const Text(
                //       'Delete all',
                //       style: TextStyle(
                //         color: Colors.red,
                //         fontSize: 15,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //     onPressed: () {
                //       showCupertinoDialog(
                //         context: context,
                //         builder: ((context) {
                //           return CupertinoAlertDialog(
                //             title: const Text(
                //               'Do you want to delete all tasks?',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: Colors.red,
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.normal,
                //               ),
                //             ),
                //             actions: [
                //               CupertinoDialogAction(
                //                 child: const Text('Yes'),
                //                 onPressed: () {
                //                   Provider.of<TaskData>(context, listen: false)
                //                       .deleteAllDataByCategory(
                //                     category,
                //                   );
                //                   Navigator.pop(context);
                //                 },
                //               ),
                //               CupertinoDialogAction(
                //                 child: const Text('Cancel'),
                //                 onPressed: () {
                //                   Navigator.pop(context);
                //                 },
                //               ),
                //             ],
                //           );
                //         }),
                //       );
                //     },
                //   ),
                // if (Provider.of<TaskData>(context)
                //         .getTasksByCategory(category)
                //         .length <=
                //     1)
                //   const SizedBox(
                //     height: 50,
                //   ),
                // const SizedBox(
                //   width: 25,
                // ),
              ],
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundWhite,
                ),
                child: Consumer<TaskData>(
                  builder: (BuildContext context, taskData, child) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: taskData.getTasksByCategory(category).length,
                      itemBuilder: (BuildContext context, int index) {
                        final task =
                            taskData.getTasksByCategory(category)[index];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          resizeDuration: const Duration(
                            seconds: 1,
                            milliseconds: 500,
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 30, left: 30),
                                  child: Text(
                                    'The task was deleted',
                                    style: TextStyle(
                                      color: AppColors.textColorHighEmphacy,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Center(
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.textColorLowEmphacy,
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: const Center(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color:
                                                AppColors.textColorHighEmphacy,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          key: Key(task.id.toString()),
                          onDismissed: (direction) {
                            audio2.play(AssetSource('bravo.wav'));
                            taskData.deleteTask(index);
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListaTile(
                              taskcategory: task.category,
                              index: index,
                              taskTile: task.taskName,
                              isChecked: task.isDone,
                              checkBoxCallback: (checkboxState) {
                                taskData.updateTask(task, index);
                                if (checkboxState == true) {
                                  audio.play(
                                    AssetSource('done.wav'),
                                    position: const Duration(seconds: 3),
                                  );
                                  fade(1.0, 0.0, 1000, audio);
                                  Future.delayed(
                                    const Duration(
                                        seconds: 4, milliseconds: 900),
                                    () {
                                      audio.dispose();
                                    },
                                  );
                                }
                                if (checkboxState == false) {
                                  fade(0.0, 1.0, 400, audio);
                                  audio.dispose();
                                }
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 4,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
