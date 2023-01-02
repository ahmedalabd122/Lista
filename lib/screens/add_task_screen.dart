import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/task.dart';
import 'package:lista/models/task_data.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String newTaskName = '';
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
                  Text('New Task  '),
                  Icon(
                    CupertinoIcons.chevron_up,
                  ),
                ],
              ),
              onPressed: () {
                if (newTaskName != '') {
                  final Task task = Task(
                    taskName: newTaskName,
                  );
                  Provider.of<TaskData>(context, listen: false).addTask(task);
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
            Flex(direction: Axis.vertical),
          ],
        ),
      ),
    );
  }
}
// class AddTaskScreen extends StatelessWidget {
//   const AddTaskScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String newTaskName = '';
//     return Container(
//         padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//         ),
//         child: Column(
//           children: [
//             const Text(
//               'Add New Task',
//               style: TextStyle(
//                   fontSize: 25,
//                   color: Color(0xff57d0a0),
//                   fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             TextField(
//               minLines: 1,
//               maxLines: 6,
//               autofocus: true,
//               textAlign: TextAlign.center,
//               onChanged: (newText) {
//                 newTaskName = newText;
//               },
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             TextButton(
//               child: const Text('Add'),
//               onPressed: () {

//                 if (newTaskName != '') {
//                   final Task task = Task(
//                     taskName: newTaskName,
//                   );
//                   Provider.of<TaskData>(context, listen: false).addTask(task);
//                   Navigator.pop(context);
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Dialog(
//                         elevation: 11,
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
//                           child: Text(
//                             'please enter you task name ..',
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             )
//           ],
//         ));
//   }
// }





              // padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              // child: Column(
              //   children: [
              //     const Text(
              //       'Add New Task',
              //       style: TextStyle(
              //           fontSize: 25,
              //           color: Color.fromARGB(255, 53, 237, 163),
              //           fontWeight: FontWeight.w500),
              //     ),
              //     const SizedBox(
              //       height: 15,
              //     ),
              //     TextField(
              //       style: const TextStyle(color: AppColors.backgroundWhite),
              //       decoration: const InputDecoration(
              //         filled: false,
              //         focusColor: Colors.white,
              //       ),
              //       cursorColor: AppColors.backgroundWhite,
              //       minLines: 1,
              //       maxLines: 6,
              //       autofocus: true,
              //       textAlign: TextAlign.center,
              //       onChanged: (newText) {
              //         newTaskName = newText;
              //       },
              //     ),
              //     const SizedBox(
              //       height: 15,
              //     ),
              //     TextButton(
              //       style: ButtonStyle(
              //         backgroundColor:
              //             MaterialStateProperty.all(AppColors.backgroundWhite),
              //       ),
              //       child: const Text(
              //         'Add',
              //         style: TextStyle(
              //           color: AppColors.secondaryColorSecondary,
              //         ),
              //       ),
              //       onPressed: () {
              //         if (newTaskName != '') {
              //           final Task task = Task(
              //             taskName: newTaskName,
              //           );
              //           Provider.of<TaskData>(context, listen: false)
              //               .addTask(task);
              //           Navigator.pop(context);
              //         } else {
              //           showDialog(
              //             context: context,
              //             builder: (context) {
              //               return const CupertinoAlertDialog(
              //                 title: Padding(
              //                   padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              //                   child: Text(
              //                     'please enter you task name ..',
              //                     textAlign: TextAlign.center,
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         }
              //       },
              //     )
              //   ],
              // ))