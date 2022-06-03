import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list_with_hive/modules/completed_task.dart';
import 'package:to_do_list_with_hive/view/screens/add_task.dart';
import 'package:to_do_list_with_hive/view/screens/home.dart';
import 'package:to_do_list_with_hive/view/theme/app_theme.dart';
import 'modules/a_task.dart';

//?we make it global to easy access it from any place in our project
const boxName = 'task';
const completedTasksBox = 'completed';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // we need to register model adapter
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CompletedTaskAdapter());
  //!open box before using it and close it in the dispose method
  await Hive.openBox<Task>(boxName);
  await Hive.openBox<CompletedTask>(completedTasksBox);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // done: implement initState
    super.initState();
    customTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // implement dispose : done
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ToDo: implement the app theme dark and light
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: customTheme.getCurrentTheme(),
      routes: {
        '/': (context) => const HomeScreen(),
        AddTaskScreen.pageRoute: (context) => const AddTaskScreen(),
      },
    );
  }
}
