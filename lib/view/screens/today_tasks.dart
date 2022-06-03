import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:to_do_list_with_hive/modules/a_task.dart';
import 'package:to_do_list_with_hive/modules/hive_boxes.dart';
import 'package:to_do_list_with_hive/view/screens/add_task.dart';
import 'package:to_do_list_with_hive/view/theme/app_theme.dart';
import 'package:to_do_list_with_hive/view/widgets/dates_widget.dart';
import 'package:to_do_list_with_hive/view/widgets/task_form.dart';

class ToDayTasks extends StatefulWidget {
  const ToDayTasks({Key? key}) : super(key: key);

  @override
  State<ToDayTasks> createState() => _ToDayTasksState();
}

class _ToDayTasksState extends State<ToDayTasks> {
  
  getTaskColor({category}) {
    switch (category) {
      case 'Education':
        return AppColors.educationCategoryColor;
      case 'Sports':
        return AppColors.sportsCategoryColor;
      case 'Meetings':
        return AppColors.meetingCategoryColor;
      case 'Friends':
        return AppColors.friendsCategoryColor;
      default:
        return AppColors.appBarColor;
        
    }
  }

  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  //calculate if the year is leap or not
  static int febDays() {
    //?if year devisable by 4
    //?if year devisable by 400
    //!1900 / 4 =475 ,1900/400 = 19/4
    int currentYear = DateTime.now().year;
    if (currentYear % 100 == 0) {
      if (currentYear % 400 == 0) {
        return 29;
      } else {
        return 28;
      }
    } else if (currentYear % 4 == 0) {
      return 29;
    }
    return 28;
  }

  Map<int, int> daysInMonths = {
    1: 31,
    2: febDays(),
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };
  Map<int, String> daysInWeek = {
    1: 'Thu',
    2: 'Fri',
    3: 'Sat',
    4: 'Sun',
    5: 'Mon',
    6: 'Tue',
    7: 'wed',
  };
  final listController = ItemScrollController();
  //*filter tasks and show just today tasks
  showJustTodayTasks(DateTime dateTime) {
    return TasksBox.getTasksBox().values.where((task) {
      return task.taskDate!.day == dateTime.day &&
          task.taskDate!.month == dateTime.month;
    }).toList();
  }

  @override
  void initState() {
    // done: implement initState
    // print(DateTime.now().weekday);
    super.initState();
    WidgetsBinding.instance!
        //!take care scrolling to the index in the list today = index-1 in the list
        .addPostFrameCallback((_) => scrollToIndex(DateTime.now().day - 1));
  }

  //todo:use this to add names of days to the months days
  int dateTime = DateTime.now().weekday;
  scrollToIndex(int index) => listController.jumpTo(index: index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          titleTextStyle: GoogleFonts.arefRuqaa(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          //automaticallyImplyLeading: false,
          title: const Text(
            'today tasks',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: AppColors.appBarColor,
          actionsIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {
                AlertDialog _confirmDeletion = AlertDialog(
                  content: const Text('delete all ?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('cancel')),
                    TextButton(
                      onPressed: () {
                        TasksBox.getTasksBox().clear();
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const Text('clear '),
                    ),
                  ],
                );
                showDialog(
                    context: context, builder: (context) => _confirmDeletion);
              },
              icon: const Icon(Icons.delete_sweep_rounded),
            ),
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen.withOpacity(.2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                if (selectedMonth > 1) {
                                  selectedMonth--;
                                } else {
                                  selectedMonth = 12;
                                }
                                selectedDate = DateTime(DateTime.now().year,
                                    selectedMonth, selectedDay);
                              });
                            },
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                color: AppColors.educationCategoryColor),
                            child: Text(
                              months[selectedMonth - 1],
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                if (selectedMonth < 12) {
                                  selectedMonth++;
                                } else {
                                  selectedMonth = 1;
                                }
                                selectedDate = DateTime(DateTime.now().year,
                                    selectedMonth, selectedDay);
                              });
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ScrollablePositionedList.builder(
                        itemScrollController: listController,
                        scrollDirection: Axis.horizontal,
                        itemCount: daysInMonths[selectedMonth]!,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            //todo:implement it on tap show just this day tasks
                            onTap: () {
                              setState(() {
                                selectedDay = index + 1;
                                selectedDate = DateTime(DateTime.now().year,
                                    selectedMonth, selectedDay);
                              });
                            },
                            child: DayDate(
                              currentDay: index + 1,
                              color: selectedDay == index + 1
                                  ? AppColors.educationCategoryColor
                                  : AppColors.sportsCategoryColor,
                              dayInWeek: daysInWeek[DateTime(
                                DateTime.now().year, //2022
                                selectedMonth - 1,
                                index + 1,
                              ).weekday],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                ValueListenableBuilder<Box<Task>>(
                  valueListenable: TasksBox.getTasksBox().listenable(),
                  builder: (context, value, _) =>
                      showJustTodayTasks(selectedDate).isEmpty
                          ? Center(
                              child: Text(
                                "don't be free today",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemBuilder: ((context, index) {
                                  List tasks = showJustTodayTasks(selectedDate);
                                  String taskCategory = tasks[index].category;
                                  Color taskColor = getTaskColor(category:  taskCategory);
                                  //todo: add Transition animation like johannes milk add in the animation
                                  //todo:course which you have . video title :
                                  //Flutter Tutorial - Transition Animation - Locations UI Design(720P_HD)
                                  return TaskForm(
                                    task: tasks[index],
                                    categoryColor: taskColor,
                                    deleteTask: () {
                                      AlertDialog _confirmDelete() {
                                        return AlertDialog(
                                          content: const Text('delete task ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'cancel',
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                TasksBox.deleteTask(index);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'delete',
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return _confirmDelete();
                                          });
                                    },
                                    editTask: () {
                                      Navigator.of(context).pushNamed(
                                          AddTaskScreen.pageRoute,
                                          arguments: {
                                            'new': false,
                                            'taskIndex': index,
                                          });
                                    },
                                    taskDone: () {
                                      TasksBox.moveToCompleted(tasks[index]);
                                      TasksBox.deleteTask(index);
                                    },
                                  );
                                }),
                                itemCount:
                                    showJustTodayTasks(selectedDate).length,
                              ),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.pageRoute, arguments: {
            'new': true,
            'taskIndex': -1,
          });
        },
        child: const Icon(
          Icons.add_task,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
