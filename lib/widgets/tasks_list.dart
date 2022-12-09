import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lista/models/task_data.dart';
import 'package:lista/widgets/tasks_tile.dart';

class ListaListView extends StatelessWidget {
  AudioPlayer audio = AudioPlayer();
  AudioPlayer audio2 = AudioPlayer();
  final assetSound = AssetsAudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, taskData, child) {
        return ListView.separated(
          itemCount: taskData.taskCount,
          itemBuilder: (BuildContext context, int index) {
            final task = taskData.tasks[index];
            return Dismissible(
              direction: DismissDirection.startToEnd,
              resizeDuration: Duration(milliseconds: 750),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              key: Key(task.id.toString()),
              onDismissed: (direction) {
                audio.play(AssetSource('bravo.wav'));
                taskData.deleteTask(task);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListaTile(
                  taskTile: task.taskName,
                  isChecked: task.isDone,
                  checkBoxCallback: (checkboxState) {
                    taskData.updateTask(task);
                    if (checkboxState == true) {
                      audio2.play(AssetSource('done.wav'));
                    }
                    if (checkboxState == false) {
                      audio2.dispose();
                    }
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 10,
          ),
        );
      },
    );
  }
}
