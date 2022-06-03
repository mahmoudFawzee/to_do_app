import 'package:flutter/material.dart';
import 'package:to_do_list_with_hive/modules/completed_task.dart';

class CompletedTaskFrom extends StatelessWidget {
  const CompletedTaskFrom(
      {Key? key, required this.task, required this.removeTask})
      : super(key: key);
  final CompletedTask task;

  // ignore: prefer_typing_uninitialized_variables
  final removeTask;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: screenHeight * .1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red.withOpacity(.3),
        ),
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Text(
            task.taskTitle,
          ),
          title: Padding(
            padding: EdgeInsets.only(
              right: screenWidth * .5,
              left: screenWidth * .25,
            ),
          ),
          trailing: IconButton(
            onPressed: removeTask,
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
