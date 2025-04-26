import 'package:flutter/material.dart';
import '../Utils/Utils.dart';
import '../Utils/clientConfig.dart';
import 'HomePageScreen.dart';
import '../Models/User.dart';
import 'package:http/http.dart' as http;

const List<String> list1 = <String>['Student', 'Business Owner'];
const List<String> list2 = <String>['Female', 'Male'];
const List<String> list3 = <String>['Islam', 'Hinduism', 'Christianity', 'Druze', 'Judaism'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterScreen> {
  var _txtfullName = TextEditingController();
  var _txtpassword = TextEditingController();
  var _txtemail = TextEditingController();

  // var _txtgender = TextEditingController();
  // var _txttype = TextEditingController();
  // var _txtreligion = TextEditingController();
  // var _txtbirthDate = TextEditingController();

  DateTime? _selectedDate;
  var _gender;
  var _religion;
  var _type;

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

  Future insertUser(BuildContext context, User us) async {
    var url = "users/insertUser.php?fullName=" + us.fullName + "&email=" + us.email + "&password=" + us.password + "&gender=" + us.gender +
              "&type=" + us.type + "&religion=" + us.religion + "&birthDate=" + us.birthDate;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    setState(() {});
    // Navigator.pop(context);
  }

  void insertNewUserFunc() {
    if (_txtfullName.text != "" && _selectedDate != null) {
      User us = new User();
      us.fullName  = _txtfullName.text;
      us.password = _txtpassword.text;
      us.email = _txtemail.text;
      us.gender = _gender;
      us.type = _type;
      us.religion = _religion;
      us.birthDate = _selectedDate.toString();

      insertUser(context, us);
      print('Register');
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePageScreen(title: 'Home Page',)));
    } else {
      var Uti2 = new Utils();
      Uti2.showMyDialog(context, "REQUIRED", "You Must Fill The Unanswered Questions");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Email :",
                  style: TextStyle(fontSize: 20, color: Colors.indigo),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _txtemail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.indigo),
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Password:",
                  style: TextStyle(fontSize: 20, color: Colors.indigo),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _txtpassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Full Name :",
                  style: TextStyle(fontSize: 20, color: Colors.indigo),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _txtfullName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.indigo),
                      border: OutlineInputBorder(),
                      hintText: 'Enter Full Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  child: const Text(
                    'Select Your Birth Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Birth Date : ${_selectedDate != null ? _selectedDate.toString() : 'No Birth Date Selected'}',
                  style: const TextStyle(fontSize: 20, color: Colors.indigo),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: list2.first,
                  onChanged: (String? newValue) {
                    _gender = newValue;
                  },
                  items: list2.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.indigo)),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: list1.first,
                  onChanged: (String? newValue) {
                    _type = newValue;

                  },
                  items: list1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.indigo)),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: list3.first,
                  onChanged: (String? newValue) {
                    _religion = newValue;
                  },
                  items: list3.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.indigo)),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        insertNewUserFunc();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50), backgroundColor: Colors.deepPurple,
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}