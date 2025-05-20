import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Task.dart';
import 'EditTaskScreen.dart';
import 'package:http/http.dart' as http;
import '../Utils/clientConfig.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.title, this.selectedDate});

  final String title;
  final DateTime? selectedDate;

  @override
  State<NewTaskScreen> createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> {

  DateTime? _selectedDate;
  final TextEditingController _taskController = TextEditingController();
  TimeOfDay? _taskTime;
  int? _duration;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  Future _selectDate(BuildContext context) async => showDatePicker(
    context: context,
    initialDate: _selectedDate!,
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
  ).then((DateTime? selected) {
    if (selected != null && selected != _selectedDate) {
      setState(() => _selectedDate = selected);
    }
  });

  Future insertTask(BuildContext context, Task tas) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("token");

    var url = "tasks/insertTask.php?howLong=" + tas.howLong.toString() + "&taskName=" + tas.taskName +
              "&statusID=1" + "&userID=" + userID.toString() + "&dateTime=" + tas.dateTime.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task Saved successfully',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.task, color: Colors.deepPurple, size: 50),
            SizedBox(height: 20),
            Text("The Task:", style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
            SizedBox(height: 20),
            Container(
              width: 350,
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Task',
                  prefixIcon: Icon(Icons.edit, color: Colors.deepPurple),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text("When?", style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 50),
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Select Your Task Date', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Text(
              'Task Date : ${_selectedDate != null ? _selectedDate.toString() : 'No Task Date Selected'}',
              style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    _taskTime = picked;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 50),
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Choose Task Time', style: const TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 30),
            Text("How Long?", style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
            SizedBox(height: 20),
            DropdownMenu<int>(
              width: 350,
              initialSelection: list.first,
              onSelected: (int? value) {
                setState(() {
                  _duration = value;
                });
              },
              dropdownMenuEntries: list.map<DropdownMenuEntry<int>>((int value) {
                return DropdownMenuEntry<int>(value: value, label: value.toString());
              }).toList(),
            ),
            SizedBox(height: 30),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  if (_taskController.text.isNotEmpty && _selectedDate != null) {
                   var tas = new Task();
                    tas.howLong = _duration!;
                    tas.taskName = _taskController.text;
                    tas.dateTime = _selectedDate.toString();
                    insertTask(context, tas);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(
                  "Create Task",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          EditTaskScreen(title: 'Edit Task',)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(
                  "Edit", style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}