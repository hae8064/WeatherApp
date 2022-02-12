import 'package:flutter/material.dart';

class TodoPlan extends StatefulWidget {
  const TodoPlan({Key? key}) : super(key: key);

  @override
  _TodoPlanState createState() => _TodoPlanState();
}

class _TodoPlanState extends State<TodoPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Todo-list"),
    );
  }
}
