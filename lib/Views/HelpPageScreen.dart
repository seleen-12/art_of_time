import 'package:flutter/material.dart';

import 'AIHelpScreen.dart';
import 'RecommendationScreen.dart';


class HelpPageScreen extends StatefulWidget {
  const HelpPageScreen({super.key, required this.title});

  final String title;

  @override
  State<HelpPageScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<HelpPageScreen> {

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
              ElevatedButton(onPressed: (){
                print('Recommendations');
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  RecommendationScreen(title: 'Recommendation',)));
              },
                child: Text("Recommendations",style: TextStyle(color: Colors.black),),),
              SizedBox(height: 70,),
              ElevatedButton(onPressed: (){
                print('AI Help');
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AIHelpScreen(title: 'AI Help',)));
              },
                child: Text("AI Help",style: TextStyle(color: Colors.black),),),
            ],
          ),
        ));
  }
}