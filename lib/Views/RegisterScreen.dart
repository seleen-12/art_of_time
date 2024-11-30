import 'package:art_of_time/Utils/DB.dart';
import 'package:flutter/material.dart';
import '../Utils/Utils.dart';
import 'HomePageScreen.dart';
import '../Models/User.dart';
import '../Utils/DB.dart';

const List<String> list1 = <String>['Student', 'Business Owner'];
const List<String> list2 = <String>['Female', 'Male'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterScreen> {
  get selectedDate => null;

  var _txtname = TextEditingController();
  var _txtphoneNumberOrEmail = TextEditingController();
  var _txtpassword = TextEditingController();

  DateTime? _selectedDate;

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
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Full Name :", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              SizedBox(height: 20,),
              Container(
                  width: 350,
                  child: TextField(
                    controller: _txtname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Full Name',
                    ),
                  )
              ),
              SizedBox(height: 70,),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Your Birth Date',
                    style: TextStyle(color: Colors.indigo)),
              ),
              const SizedBox(height: 20),
              Text(
                'Birth Date : ${_selectedDate != null ? _selectedDate.toString() : 'No Birth Date Selected'}',
                style: const TextStyle(fontSize: 20, color: Colors.indigo),
              ),
              SizedBox(height: 70,),
              DropdownMenu<String>(
                initialSelection: list2.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list2.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              SizedBox(height: 70,),
              DropdownMenu<String>(
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
              SizedBox(height: 70,),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    insertNewUserFunc();
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}