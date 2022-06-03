import 'package:hive_flutter/adapters.dart';
part 'completed_task.g.dart';

@HiveType(typeId: 2)
class CompletedTask extends HiveObject {
  @HiveField(0)
  late String taskTitle;
  CompletedTask({required this.taskTitle,});
}
//todo:use it to display in completed tasks 
//! take task title to the completed one then delete that task