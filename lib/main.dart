import 'package:flutter/material.dart';
import 'Models/User.dart';
import 'Utils/DB.dart';
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
              Text("Phone Number :",
                  style: TextStyle(fontSize: 20, color: Colors.indigo)),
              SizedBox(height: 20,),
              Container(
                  width: 350,
                  child: TextField(
                    controller: _txtphoneNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Phone Number',
                    ),
                  )
              ),
              SizedBox(height: 70,),
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
              SizedBox(height: 70,),
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
              SizedBox(height: 70,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        checkLogin();
                      },
                      child: Text(
                        "Log In", style: TextStyle(color: Colors.indigo),),),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(title: 'Register Page',)));
                      },
                      child: Text(
                        "Sign Up", style: TextStyle(color: Colors.indigo),),),
                  ]
              ),
              // TextButton(
              //   onPressed: () => showDialog<String>(
              //     context: context,
              //     builder: (BuildContext context) => AlertDialog(
              //       title: const Text('AlertDialog Title'),
              //       content: const Text('AlertDialog description'),
              //       actions: <Widget>[
              //         TextButton(
              //           onPressed: () => Navigator.pop(context, 'Cancel'),
              //           child: const Text('Cancel'),
              //         ),
              //         TextButton(
              //           onPressed: () => Navigator.pop(context, 'OK'),
              //           child: const Text('OK'),
              //         ),
              //       ],
              //     ),
              //   ),
              //   child: Text("Log In",style: TextStyle(color: Colors.indigo),),), SizedBox(width:10,),
            ],
          ),
        ));
  }
}