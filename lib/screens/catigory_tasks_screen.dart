import 'package:audioplayers/audioplayers.dart';
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
          children: [
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
                            taskData.deleteTask(task, index);
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
