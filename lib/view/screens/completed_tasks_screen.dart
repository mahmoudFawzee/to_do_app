import 'package:flutter/material.dart';
import 'package:to_do_list_with_hive/modules/hive_boxes.dart';
import 'package:to_do_list_with_hive/view/widgets/completed_task_form.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AlertDialog _alert = AlertDialog(
                title: const Text('Delete all ?'),
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
                      CompletedBox.getCompletedBox().clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'delete',
                    ),
                  ),
                ],
              );
              showDialog(context: context, builder: (context) => _alert);
            },
            icon: const Icon(Icons.delete_sweep_rounded),
          ),
        ],
        title: Text(
          'Completed tasks',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: CompletedBox.getCompletedBox().listenable(),
          builder: (context, value, _) => ListView.builder(
            itemCount: CompletedBox.displayCompleted().length,
            itemBuilder: ((context, index) {
              List completedTasks = CompletedBox.displayCompleted();
              return CompletedTaskFrom(
                task: completedTasks[index],
                removeTask: () {
                  CompletedBox.removeCompleted(index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
