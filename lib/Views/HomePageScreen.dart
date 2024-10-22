import 'package:flutter/material.dart';

import 'EditProfileScreen.dart';

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
          backgroundColor:Colors.grey,
          title: Text("Home Page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          EditProfileScreen(title: 'Edit Profile Screen',)));
                },
                  child: Icon(Icons.perm_identity_sharp, color: Colors.black87,),),
            ],
          ),
        ));
  }
}