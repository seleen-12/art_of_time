import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/checkLoginModel.dart';
import 'Utils/clientConfig.dart';
import 'Views/HomePageScreen.dart';
import 'Views/RegisterScreen.dart';
import 'Utils/Utils.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

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


    Future checkLogin(BuildContext context) async {
      var url = "login/checkLogin.php?email=" + _txtemail.text + "&password=" +
          _txtpassword.text;
      final response = await http.get(Uri.parse(serverPath + url));
      print(serverPath + url);
      if (checkLoginModel.fromJson(jsonDecode(response.body)).userID == 0) {
        var uti = new Utils();
        uti.showMyDialog(context, "Error", "Email Or Password Is Incorrect");
      }
      else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('token', checkLoginModel
            .fromJson(jsonDecode(response.body))
            .userID!);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                HomePageScreen(title: 'Home Page',)));
      }
    }

    checkConction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      }
    } on SocketException catch (_) {
      var uti = new Utils();
      uti.showMyDialog(context, "NO INTERNET!", "The App Requires An Internet Connection, Please Connect.");
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
                        checkLogin(context);
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