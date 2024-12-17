import 'package:flutter/material.dart';

class AIHelpScreen extends StatefulWidget {
  const AIHelpScreen({super.key, required this.title});

  final String title;

  @override
  State<AIHelpScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<AIHelpScreen> {

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
              Text("AI Help")
            ],
          ),
        ));
  }
}
