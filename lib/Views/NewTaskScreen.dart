import 'package:art_of_time/Utils/DB.dart';
import 'package:flutter/material.dart';
import '../Utils/Utils.dart';
import 'HomePageScreen.dart';
import '../Models/User.dart';
import '../Utils/DB.dart';


const List<String> list1 = <String>['1', '15' , '30','45','1h','1.5h'];
const List<String> list2 = <String>['Black', 'Red'];

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<NewTaskScreen> createState() => RegisterPageState();
}

class RegisterPageState extends State<NewTaskScreen> {
  get selectedDate => null;

  var _txtname = TextEditingController();
  var _txtphoneNumberOrEmail = TextEditingController();
  var _txtpassword = TextEditingController();

  DateTime? _selectedDate;
  Color? _selectedColor = Colors.black;

  Future _selectDate(BuildContext context) async => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      ).then((DateTime? selected) {
        if (selected != null && selected != _selectedDate) {
          setState(() => _selectedDate = selected);
        }
      });

  void insertNewUserFunc() {
    if (_txtname.text != "" && _selectedDate != null) {
      User us = new User();
      us.name = _txtname.text;
      us.password = _txtpassword.text;
      us.phoneNumberOrEmail = _txtphoneNumberOrEmail.text;
      // us.userID=3;
      insertUser(us);
      print('Register');
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) =>
      //         HomePageScreen(title: 'Home Page',)));
      // context:Text(_txtname.text +"_"+ _txtpassword.text +""+ _txtphoneNumberOrEmail.text );
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
                    controller: _txtphoneNumberOrEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Task',
                    ),
                  )
              ),
              Text("When ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),

              SizedBox(height: 250,),
              Text("How Long ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              DropdownMenu<String>(
//              color: _selectedColor,
                initialSelection: list1.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list1.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),

              SizedBox(height: 250,),
              Text("What Color ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              DropdownMenu<String>(
//              color: _selectedColor,
                initialSelection: list1.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list1.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),


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