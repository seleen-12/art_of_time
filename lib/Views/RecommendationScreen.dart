import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key, required this.title});

  final String title;

  @override
  State<RecommendationScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<RecommendationScreen> {

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
              Text("Recommendation")
            ],
          ),
        ));
  }
}