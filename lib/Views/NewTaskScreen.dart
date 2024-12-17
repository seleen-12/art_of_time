import 'package:art_of_time/Utils/DB.dart';
import 'package:flutter/material.dart';
import '../Models/Task.dart';
import '../Utils/Utils.dart';

const List<int> list = <int>[1,5,10,15,30,45,60];

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<NewTaskScreen> createState() => RegisterPageState();
}

class RegisterPageState extends State<NewTaskScreen> {
  get selectedDate => null;

  var _txttaskName = TextEditingController();
  var _txthowLong = TextEditingController();


  void insertNewUserFunc() {
    if (_txttaskName.text != "" && _txthowLong.text != 0) {
      Task ts = new Task();
      ts.taskName  = _txttaskName.text;
      ts.howLong = list.first;
      // us.userID=3;
      insertTask(ts);
      print('Register');
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) =>
      //         HomePageScreen(title: 'Home Page',)));
      // context:Text(_txttaskName.text +"_"+ _txthowLong.text );
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
          backgroundColor: Colors.grey,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("The Task :", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              SizedBox(height: 20,),
              Container(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Task',
                    ),
                  )
              ),
              SizedBox(height: 30,),
              Text("When ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),

              SizedBox(height: 250,),
              Text("How Long ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              SizedBox(height: 20,),
              DropdownMenu<int>(
//              color: _selectedColor,
                initialSelection: list.first,
                onSelected: (int? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list.map<DropdownMenuEntry<int>>((int value) {
                  return DropdownMenuEntry<int>(value: value, label: value.toString());
                }).toList(),
              ),

              SizedBox(height: 30,),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    insertNewUserFunc();
                  },
                  child: Text(
                    "Create Task",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ]),
              SizedBox(width:25,),
              ElevatedButton(onPressed: (){
                print('Edit');
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditTask(title: 'Edit Task',)));
              },
                child: Text("Edit",style: TextStyle(color: Colors.indigo),),), SizedBox(width:10,),
              // ElevatedButton(onPressed: (){
              //   print('Create Task');
              //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterScreen(title: 'Log In Page',)));
              // },
              //   child: Text("Sign Up",style: TextStyle(color: Colors.indigo),),),
            ],
          ),
        ));
  }
}