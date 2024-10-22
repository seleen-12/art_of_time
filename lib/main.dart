import 'package:flutter/material.dart';
import 'Views/HomePageScreen.dart';
import 'Views/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.grey,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Phone Number Or Email : ", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              Container(
                  width: 500,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Phone Number Or Email',
                    ),
                  )
              ),
              Text("     "),
              Text("     "),

              Text("Password : ", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              Container(
                  width: 500,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                  )
              ),
              Text("     "),
              Text("     "),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      print('Log In');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen(title: 'Home Page',)));
                    },
                      child: Text("Log In",style: TextStyle(color: Colors.indigo),),), SizedBox(width:10,),
                    ElevatedButton(onPressed: (){
                      print('Sign Up');
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterScreen(title: 'Log In Page',)));
                    },
                      child: Text("Sign Up",style: TextStyle(color: Colors.indigo),),),
                  ]
              ),
            ],
          ),
        ));
  }
}