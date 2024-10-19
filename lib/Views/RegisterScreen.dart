import 'package:flutter/material.dart';


  class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key, required this.title});

  final String title;

  @override
  State<Registerscreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Registerscreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.grey,
          title: Text("Register Page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("User Name :", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              Container(
                  width: 500,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your User Name',
                    ),
                  )
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      print('Register');
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Registerscreen(title: 'asd',)));
                    },
                      child: Text('Register'),),
                  ]
              ),
            ],
          ),
        ));
  }
}