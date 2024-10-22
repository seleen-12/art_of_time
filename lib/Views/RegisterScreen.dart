import 'package:flutter/material.dart';
import 'HomePageScreen.dart';

const List<String> list1 = <String>['Student','Business Owner'];
const List<String> list2 = <String>['Female','Male'];

  class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterScreen> {
  // get selectedDate => null;

final _txtUserName = TextEditingController();
final _txtName = TextEditingController();

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

              Text(" Name :",
                  style: TextStyle(fontSize: 20, color: Colors.indigo)),

              Container(
                  width: 500,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Name',
                    ),
                  )
              ),
              Text("     "),
              Text("     "),

              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Your Birth Date' ,style: TextStyle(color: Colors.indigo)),
              ),
              const SizedBox(height: 20),
              Text(
                'Birth Date : ${_selectedDate != null ? _selectedDate.toString() : 'No date selected'}',
                style: const TextStyle(fontSize: 20, color: Colors.indigo ),
              ),
              Text("     "),
              Text("     "),

              DropdownMenu<String>(
                initialSelection: list2.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries: list2.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              Text("     "),

              DropdownMenu<String>(
              initialSelection: list1.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  var dropdownValue = value!;
                });
              },
              dropdownMenuEntries: list1.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
              Text("     "),
              Text("     "),
              Text("     "),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {
                      print('Register');
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              HomePageScreen(title: 'Home Page',)));
                    },
                      child: Text(
                        "Register", style: TextStyle(color: Colors.indigo),),),
                  ]
              ),
            ],),
        )
    );
  }
}