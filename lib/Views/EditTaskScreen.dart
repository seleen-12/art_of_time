import 'dart:convert';
import 'package:art_of_time/Models/Task.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Status.dart';
import '../Utils/clientConfig.dart';

const List<int> list = <int>[1, 5, 10, 15, 30, 45, 60];

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<EditTaskScreen> createState() => EditTaskScreenState();
}

class EditTaskScreenState extends State<EditTaskScreen> {
  var _txtHowLong = TextEditingController();
  var _txtTaskName = TextEditingController();
  DateTime? _selectedDate;
  Task? _currTask;
  int? _duration;
  List<Status> _statuses = [];
  Status? _selectedStatus;

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

  Future updateTask(BuildContext context, Task tas) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("token");

    var url = "tasks/updateTask.php?howLong=" + tas.howLong.toString() + "&taskName=" + tas.taskName +
              "&statusID=" + tas.statusID.toString() + "&userID=" + userID.toString() +
              "&taskID=" + tas.taskID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Update Task Saved successfully',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
    );
    Navigator.of(context).pop();
  }


  @override
  void initState() {
    super.initState();
    getTaskDetails();

    fetchStatuses().then((statuses) {
      setState(() {
        _statuses = statuses;

        // _selectedStatus =
        // _selectedStatus = _statuses.firstWhere(
        //       (status) => status.statusID == '3',
        //   orElse: () => _statuses.first, // fallback
        // );
        _selectedStatus?.statusID = _currTask!.statusID;
        _selectedStatus?.statusName = _currTask!.statusName;

      });
    });



  }

  getTaskDetails () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? taskID = await prefs.getInt('taskID');
    var url = "tasks/getTaskDetails.php?taskID=$taskID";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    // Map<String, dynamic> i in json.decode(response.body)
    _currTask = Task.fromJson(json.decode(response.body));

    setState(() {
      _txtTaskName.text = _currTask!.taskName;
      _txtHowLong.text = _currTask!.howLong.toString();
      // _selectedStatus = new Status();
      _selectedStatus?.statusID = _currTask!.statusID;
      _selectedStatus?.statusName = _currTask!.statusName;

    });
  }


  editTask(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? taskID = await prefs.getInt('taskID');

    Task tas = new Task();
    tas.taskName = _txtTaskName.text;
    tas.howLong = int.parse(_txtHowLong.text);
    tas.taskID = taskID!;
    tas.statusID = _selectedStatus!.statusID;

    updateTask(context, tas);
  }


  Future<List<Status>> fetchStatuses() async {
    // final response = await http.get(Uri.parse('http://yourdomain.com/statuses.php'));
    var url = "statuses/getStatuses.php";

    // if (response.statusCode == 200) {
    //   List jsonData = json.decode(response.body);
    //   return jsonData.map((item) => Status.fromJson(item)).toList();
    // } else {
    //   throw Exception('Failed to load statuses');
    // }

    print(serverPath + url);
    final response = await http.get(Uri.parse(serverPath + url));
    List<Status> arr = [];
    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Status.fromJson(i));
    }
    return arr;
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "The Task:",
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              child: TextField(
                  controller: _txtTaskName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Task',
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "When?",
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 50),
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text(
                'Select Your Task Date',
                style: TextStyle(color: Colors.white),
              ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Picked Time: ${picked.format(context)}',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 50),
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                'Choose Task Time',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "How Long ?",
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            DropdownMenu<int>(
              width: 350,
              initialSelection: list.first,
              onSelected: (int? value) {
                setState(() {
                  var dropdownValue = value!;
                });
              },
              controller: _txtHowLong,
              dropdownMenuEntries: list.map<DropdownMenuEntry<int>>((int value) {
                return DropdownMenuEntry<int>(value: value, label: value.toString());
              }).toList(),
            ),
            SizedBox(height: 30),


             DropdownButton<Status>(
              value: _selectedStatus,
              hint: Text('Select Status'),
              items: _statuses.map((status) {
                return DropdownMenuItem<Status>(
                  value: status,
                  child: Text(status.statusName),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
            ),


          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {

                    editTask(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(
                    "Update Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}