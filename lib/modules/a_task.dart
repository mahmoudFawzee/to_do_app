import 'package:hive_flutter/hive_flutter.dart';
part 'a_task.g.dart';
@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  late String taskTitle;
  @HiveField(1)
  late String? taskDetails;
  @HiveField(2)
  late DateTime? taskDate;
  @HiveField(5)
  late String? category;
  Task({
    required this.taskTitle,
    required this.taskDetails,
    required this.taskDate,
    required this.category
  });
}
//! then we need to generate model adapter using terminal
