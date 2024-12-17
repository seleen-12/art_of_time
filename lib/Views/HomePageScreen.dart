import 'package:flutter/material.dart';
import 'EditProfileScreen.dart';
import 'HelpPageScreen.dart';
import 'NewTaskScreen.dart';

  class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<HomePageScreen> {

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
                  print('+');
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  NewTaskScreen(title: 'New Task',)));
                },
                  child: Text("+",style: TextStyle(color: Colors.black),),),
              SizedBox(height: 70,),
              ElevatedButton(onPressed: (){
                print('?');
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  HelpPageScreen(title: 'New Task',)));
              },
                child: Text("?",style: TextStyle(color: Colors.black),),),
              SizedBox(height: 70,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProfileScreen(title: 'Edit Profile',)));
              },
                child: Icon(Icons.account_circle_rounded),)
            ],
          ),
        ));
  }
}
