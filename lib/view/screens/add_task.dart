import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_with_hive/modules/a_task.dart';
import 'package:to_do_list_with_hive/modules/hive_boxes.dart';
import 'package:to_do_list_with_hive/view/theme/app_theme.dart';
import 'package:to_do_list_with_hive/view/widgets/category.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  static const pageRoute = '/add_task_page';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskTitleController = TextEditingController();
  final _taskDetailsController = TextEditingController();
  String? startSelectedDateString;
  bool isActive = false;
  DateTime startDate = DateTime.now();
  TimeOfDay? startTime;
  int? selected;
  String taskCategory = 'other';
  setCategory(
    String category,
    int index,
  ) {
    setState(() {
      taskCategory = category;
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArges =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    bool isNew = routeArges['new'] as bool;
    int index = routeArges['taskIndex'] as int;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        automaticallyImplyLeading: false,
        title: Text(isNew ? 'new task' : 'edit task ',
            style: Theme.of(context).textTheme.headline5),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel_outlined))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .035,
                    child: Text(
                      isNew ? 'Task Title' : 'New Title',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                textField(
                  maxLines: null,
                  textEditingController: _taskTitleController,
                  fieldFunction: 'title...',
                  isTitle: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .035,
                    child: const Text(
                      'Category',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                //*categories that user can chose between them to make its tasks in category
                categories(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        child: Text(
                          startSelectedDateString == null
                              ? 'start date'
                              : '$startSelectedDateString',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: () async {
                          var date = await showDialog(
                              context: context,
                              builder: (context) {
                                var selectedDate = DatePickerDialog(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 5),
                                  lastDate: DateTime(DateTime.now().year + 10),
                                );
                                return selectedDate;
                              });
                          var time = await showDialog(
                              context: context,
                              builder: (context) {
                                var selectedTime = const TimePickerDialog(
                                  initialTime: TimeOfDay(hour: 00, minute: 00),
                                );
                                return selectedTime;
                              });
                          try {
                            setState(() {
                              startDate = date;
                              startTime = time;
                              startDate = DateTime(
                                startDate.year,
                                startDate.month,
                                startDate.day,
                                startTime!.hour,
                                startTime!.minute,
                              );
                              startSelectedDateString =
                                  DateFormat('yyyy/MM/dd kk:mm')
                                      .format(startDate);
                            });
                          } catch (e) {
                            setState(() {
                              startSelectedDateString = 'not selected';
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                  height: 50,
                  color: Colors.black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .035,
                  child: const Text(
                    'Description',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                textField(
                  maxLines: 5,
                  textEditingController: _taskDetailsController,
                  fieldFunction: 'details...',
                  isTitle: false,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * .7,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          //? never activate adding button until adding title for the task
          onPressed: isActive
              ? () {
                  try {
                    //!used to just know if you edit an exist task of add new one
                    //if index which comes from the route equal -1 so it's new one
                    //else it's old and you edit it so you need it's index to edit it
                    //which comes from the previous screen.
                    Task? oldTask = index == -1
                        ? null
                        : TasksBox.getTasksBox().getAt(index);
                    Task _task = Task(
                      taskTitle: _taskTitleController.value.text,
                      taskDetails: _taskDetailsController.value.text,
                      taskDate: DateTime(
                        //todo:add exception handling for this line because of the nullability of date and time
                        //todo : as a hint for the user to enter them
                        startDate.year,
                        startDate.month,
                        startDate.day,
                        startTime!.hour,
                        startTime!.minute,
                      ),
                      
                      category: taskCategory,
                    );
                    //!bool value comes from the previous screen to check if the task new or not 
                    //based on which button the user press to move to here
                    //if edit task button then false
                    //if add button then true
                    isNew
                        ? TasksBox.addTask(_task)
                        : TasksBox.updateTask(oldTask!, _task);
                  } catch (e) {
                    Task? oldTask = index == -1
                        ? null
                        : TasksBox.getTasksBox().getAt(index);
                    Task _task = Task(
                      taskTitle: _taskTitleController.value.text,
                      taskDetails: _taskDetailsController.value.text == ''
                          ? null
                          : _taskDetailsController.value.text,
                      taskDate: DateTime(
                        //todo:add exception handling for this line because of the nullability of date and time
                        //todo : as a hint for the user to enter them
                        startDate.year,
                        startDate.month,
                        startDate.day,
                      ),
                      category: taskCategory,
                    );
                    isNew
                        ? TasksBox.addTask(_task)
                        : TasksBox.updateTask(oldTask!, _task);
                  }
                  Navigator.of(context).pop();
                }
              : null,
          child: Text(
            isNew ? 'Add Task' : 'Edit Task',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Wrap categories() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        Category(
          categoryName: ' Education',
          categoryColor: AppColors.educationCategoryColor,
          categoryIcon: '📝',
          isSelected: 0 == selected,
          onTapFunction: () {
            setCategory('Education', 0);
          },
        ),
        Category(
          categoryName: ' Sport',
          categoryColor: AppColors.sportsCategoryColor,
          categoryIcon: '⚽',
          isSelected: 1 == selected,
          onTapFunction: () {
            setCategory('Sports', 1);
          },
        ),
        Category(
          categoryName: ' Meetings',
          categoryColor: AppColors.meetingCategoryColor,
          categoryIcon: '🏃',
          isSelected: 2 == selected,
          onTapFunction: () {
            setCategory('Meetings', 2);
          },
        ),
        Category(
          categoryName: ' Friends',
          categoryColor: AppColors.educationCategoryColor,
          categoryIcon: '👋',
          isSelected: 3 == selected,
          onTapFunction: () {
            setCategory('Friends', 3);
          },
        ),
        Category(
          categoryName: 'other',
          categoryColor: AppColors.appBarColor,
          categoryIcon: '',
          isSelected: 4 == selected,
          onTapFunction: () {
            setCategory('other', 4);
          },
        ),
      ],
    );
  }
  TextField textField({
    int? maxLines,
    required TextEditingController? textEditingController,
    required String? fieldFunction,
    required bool isTitle,
  }) {
    return TextField(
      onChanged: (value) {
        //*isTitle bool variable passed to the function calling
        if (isTitle) {
          if (value.isEmpty) {
            setState(() {
              isActive = false;
            });
          } else {
            setState(() {
              isActive = true;
            });
          }
        }
      },
      maxLines: maxLines,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: fieldFunction,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
      ),
    );
  }
}