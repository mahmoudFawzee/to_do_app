import 'package:flutter/material.dart';

class DayDate extends StatelessWidget {
  const DayDate({
    Key? key,
    required this.currentDay,
    required this.color,
    required this.dayInWeek,
  }) : super(key: key);

  final int currentDay;
  final Color color;
  final String? dayInWeek;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.18,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Text(dayInWeek!),
              Text(
                '$currentDay',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
