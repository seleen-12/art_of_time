import 'package:flutter/material.dart';
import '../Models/User.dart';
import '../Utils/DB.dart';
import '../Utils/Utils.dart';
import 'HomePageScreen.dart';

const List<String> list1 = <String>['Student', 'Business Owner'];
const List<String> list2 = <String>['Female', 'Male'];
const List<String> list3 = <String>['Islam', 'Hinduism', 'Christianity','Druze','Judaism'];

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.title});

  final String title;

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  var _txtfullName = TextEditingController();
  var _txtpassword = TextEditingController();
  var _txtemail = TextEditingController();

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
    if (_txtfullName.text != "" && _selectedDate != null) {
      User us = new User();
      us.fullName  = _txtfullName .text;
      us.password = _txtpassword.text;
      us.email = _txtemail.text;
      insertUser(us);
      print('Register');
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
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Full Name :", style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Container(
                width: 350,
                child: TextField(
                  controller: _txtfullName,
                  decoration: InputDecoration(
                    hintText: 'Enter Full Name',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Select Your Birth Date',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Birth Date : ${_selectedDate != null ? _selectedDate.toString() : 'No Birth Date Selected'}',
                style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
              SizedBox(height: 30),
              DropdownMenu<String>(
                width: 350,
                initialSelection: list2.first,
                onSelected: (String? value) {
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list2.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              SizedBox(height: 30),
              DropdownMenu<String>(
                width: 350,
                initialSelection: list1.first,
                onSelected: (String? value) {
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list1.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              SizedBox(height: 30),
              DropdownMenu<String>(
                width: 350,
                initialSelection: list3.first,
                onSelected: (String? value) {
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list3.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  insertNewUserFunc();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}