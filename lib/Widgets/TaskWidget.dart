import 'package:flutter/material.dart';

import '../constants.dart';
class TasksWidget extends StatelessWidget {

  final String tasks;
  final String taskTextUp;

  const TasksWidget({
    Key key, this.tasks, this.taskTextUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          tasks,
          style: TextStyle(fontSize: 25, color: kTitleColor),
        ),
        SizedBox(width: 10,),
        Column(
          children: <Widget>[
            Text(
              taskTextUp,
              style: TextStyle(
                color: kTitleColor,
                fontSize: 15,
              ),
            ),
            Text(
              "Tasks",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kTitleColor,
                fontSize: 15,
              ),
            )
          ],
        )
      ],
    );
  }
}
