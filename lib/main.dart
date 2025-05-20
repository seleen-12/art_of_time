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
      home: const LoginPage(title: ''),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

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
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Welcome to the App",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Email :",
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 350,
                    child: TextField(
                      controller: _txtemail,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Email',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Password :",
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 350,
                    child: TextField(
                      obscureText: true,
                      controller: _txtpassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          checkLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50), backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  RegisterScreen(title: 'Register Page',)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          side: BorderSide(color: Colors.deepPurple, width: 2),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}