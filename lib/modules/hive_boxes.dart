import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list_with_hive/main.dart';
import 'package:to_do_list_with_hive/modules/a_task.dart';
import 'package:to_do_list_with_hive/modules/completed_task.dart';

//*just to return the tasks box to easy work with it
class TasksBox {
  static Box<Task> getTasksBox() => Hive.box<Task>(boxName);
  static addTask(Task task) {
    TasksBox.getTasksBox().add(task);
  }

  static void deleteTask(int index) {
    TasksBox.getTasksBox().deleteAt(index);
  }

  static void moveToCompleted(Task task) {
    CompletedTask completedTask = CompletedTask(
      taskTitle: task.taskTitle,
    );
    CompletedBox.getCompletedBox().add(completedTask);
  }
//*user able to change all task properties
  static updateTask(Task oldTask, Task newTask) {
    oldTask.taskTitle = newTask.taskTitle;
    oldTask.taskDetails = newTask.taskDetails;
    oldTask.taskDate = newTask.taskDate;
    oldTask.category = newTask.category;
    oldTask.save();
  }
}

class CompletedBox {
  static Box<CompletedTask> getCompletedBox() =>
      Hive.box<CompletedTask>(completedTasksBox);
  static List displayCompleted() {
    List<CompletedTask> completed =
        CompletedBox.getCompletedBox().values.toList();
    return completed;
  }

  static void removeCompleted(int index) {
    CompletedBox.getCompletedBox().deleteAt(index);
  }
}
