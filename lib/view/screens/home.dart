import 'package:flutter/material.dart';
import 'package:to_do_list_with_hive/view/screens/completed_tasks_screen.dart';
import 'package:to_do_list_with_hive/view/screens/settings.dart';
import 'package:to_do_list_with_hive/view/screens/today_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  List<Widget> pages = const [
    CompletedTasksScreen(),
    ToDayTasks(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            height: MediaQuery.of(context).size.height * .09,
            indicatorColor: Colors.white.withOpacity(
              .5,
            ),
            labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ))),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 1),
          backgroundColor: Colors.lightGreen.withOpacity(.2),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.done_all),
              icon: Icon(Icons.done_all_outlined),
              label: 'done',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.task_alt),
              icon: Icon(Icons.task_alt_outlined),
              label: 'Tasks',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'settings',
            ),
          ],
        ),
      ),
    );
  }
}
