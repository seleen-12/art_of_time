import 'dart:io';

import 'package:flutter/material.dart';
import 'Models/User.dart';
import 'Views/HomePageScreen.dart';
import 'Views/RegisterScreen.dart';
import 'Utils/Utils.dart';

void main() {
  runApp(const MyApp());
}

var _txtphoneNumber = TextEditingController();
var _txtpassword = TextEditingController();
var _txtemail = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void checkLogin() {
    if (_txtphoneNumber.text != "" &&_txtpassword.text != "" ) {
      User us = new User();
      us.password = _txtpassword.text;
      us.phoneNumber = _txtphoneNumber.text;
      // us.userID=3;
      checkLogin();
      print('checkLogin');
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) =>
      //         HomePageScreen(title: 'Home Page',)));
      // context:Text(_txtfullName.text +"_"+ _txtpassword.text +""+ _txtphoneNumber.text +""+ _txtemail.text );
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePageScreen(title: 'Home Page',)));
    } else {
      var Uti2 = new Utils();
      Uti2.showMyDialog(
          context, "REQUIRED", "You Must Fill The Unanswered Questions");
    }
  }


  checkConction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected to internet');// print(result);// return 1;
      }
    } on SocketException catch (_) {
      // print('not connected to internet');// print(result);
      var uti = new Utils();
      uti.showMyDialog(context, "אין אינטרנט", "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
      return;
    }
  }


  @override
  Widget build(BuildContext context) {

    checkConction();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Email :",
                  style: TextStyle(fontSize: 20, color: Colors.indigo)),
              SizedBox(height: 20,),
              Container(
                  width: 350,
                  child: TextField(
                    controller: _txtemail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email',
                    ),
                  )
              ),
              SizedBox(height: 40,),
              Text("Password :",
                  style: TextStyle(fontSize: 20, color: Colors.indigo)),
              SizedBox(height: 20,),
              Container(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    controller: _txtpassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                  )
              ),
              SizedBox(height: 40,),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                HomePageScreen(title: 'Home Page',)));
                      },
                      style: ElevatedButton.styleFrom(minimumSize: Size(350,50)
                      ),
                      child: Text(
                        "Log In", style: TextStyle(color: Colors.indigo, fontSize: 18),),),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(title: 'Register Page',)));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent,),
                      child:
                      Text(
                        "Sign Up", style: TextStyle(color: Colors.black),),),
                  ]
              ),
            ],
          ),
        ));
  }
}