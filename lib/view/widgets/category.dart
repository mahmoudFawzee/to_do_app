import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.categoryName,
    required this.categoryColor,
    required this.categoryIcon,
    required this.onTapFunction,
    required this.isSelected,
  }) : super(key: key);
  final String categoryName;
  final Color categoryColor;
  final String categoryIcon;
  final bool isSelected;
  // ignore: prefer_typing_uninitialized_variables
  final onTapFunction;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        decoration: BoxDecoration(
          color: categoryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: isSelected == true ? 3 : 0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        //todo:implement onTap function
        //it will set the category id to the task and store it in the hive database
        //todo:you need to add ID field into task class and rebuild the task.g.dart class

        child: Text(
          ' $categoryIcon $categoryName',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
