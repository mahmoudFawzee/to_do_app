//todo:widget for on tap on a certain task its details appear like title details data time ....etc
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_with_hive/view/theme/app_theme.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({
    Key? key,
    required this.task,
    required this.categoryColor,
    required this.deleteTask,
    required this.editTask,
    required this.taskDone,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final task;
  // ignore: prefer_typing_uninitialized_variables
  final categoryColor;
  // ignore: prefer_typing_uninitialized_variables
  final deleteTask;
  // ignore: prefer_typing_uninitialized_variables
  final editTask;

  // ignore: prefer_typing_uninitialized_variables
  final taskDone;

  String stringDate() {
    if (task.taskDate == null) {
      return 'not set';
    }
    return DateFormat('kk:mm').format(task.taskDate);
  }

  String stringDetails() {
    if (task.taskDetails == null) {
      return '';
    }
    return task.taskDetails;
  }

  getTaskIcon(category) {
    return category == 'Sports'
        ? '⚽'
        : category == 'Education'
            ? '📝'
            : category == 'Meetings'
                ? '🏃'
                : category == 'Friends'
                    ? '👋'
                    : '✅';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: categoryColor,
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: Text(task.taskTitle)),
                        Expanded(flex: 3, child: Text(stringDetails()))
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.textButtonColor,
                    ),
                    //todo:here put an icon depends on the task category
                    //*it can be ball or note or meeting icon
                    child: InkWell(
                      onTap: taskDone,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          getTaskIcon(task.category),
                          style: const TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
            color: Colors.black,
            height: 1,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, left: 8, right: 8, bottom: 2),
                      ),
                      Text(
                        stringDate(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: deleteTask,
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                    IconButton(
                      onPressed: editTask,
                      icon: const Icon(
                        Icons.edit,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
