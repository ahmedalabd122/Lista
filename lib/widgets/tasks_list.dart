import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:lista/models/task_data.dart';
import 'package:lista/widgets/tasks_tile.dart';

class ListaListView extends StatelessWidget {
  AudioPlayer audio = AudioPlayer(playerId: '1');
  AudioPlayer audio2 = AudioPlayer(playerId: '2');

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, taskData, child) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: taskData.taskCount,
          itemBuilder: (BuildContext context, int index) {
            final task = taskData.tasks[index];
            print(task.date);
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
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: const Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: AppColors.textColorHighEmphacy,
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
                  id: task.id,
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
                        const Duration(seconds: 4, milliseconds: 900),
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
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 4,
          ),
        );
      },
    );
  }
}

void fade(double to, double from, int len, AudioPlayer audio) {
  double vol = from;
  double diff = to - from;
  double steps = (diff / 0.01).abs();
  int stepLen = max(4, (steps > 0) ? len ~/ steps : len);
  int lastTick = DateTime.now().millisecondsSinceEpoch;

  // // Update the volume value on each interval ticks
  Timer.periodic(Duration(milliseconds: stepLen), (Timer t) {
    var now = DateTime.now().millisecondsSinceEpoch;
    var tick = (now - lastTick) / len;
    lastTick = now;
    vol += diff * tick;

    vol = max(0, vol);
    vol = min(1, vol);
    vol = (vol * 100).round() / 100;

    audio.setVolume(vol); // change this

    if ((to < from && vol <= to) || (to > from && vol >= to)) {
      if (t != null) {
        t.cancel();
      }
      audio.setVolume(vol); // change this
    }
  });
}
