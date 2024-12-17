import 'package:flutter/material.dart';


class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<EditTaskScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<EditTaskScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Edit Task")
            ],
          ),
        ));
  }
}
