import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EditTaskScreen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.title, this.selectedDate});

  final String title;
  final DateTime? selectedDate;

  @override
  State<NewTaskScreen> createState() => RegisterPageState();
}

class RegisterPageState extends State<NewTaskScreen> {
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
            Text("The Task :", style: TextStyle(fontSize: 20, color: Colors.indigo)),
            SizedBox(height: 20),
            Container(
              width: 350,
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Task',
                ),
              ),
            ),
            SizedBox(height: 30),
            Text("When ?", style: TextStyle(fontSize: 20, color: Colors.indigo)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(minimumSize: Size(350, 50)),
              child: const Text('Select Your Task Date', style: TextStyle(color: Colors.indigo)),
            ),
            const SizedBox(height: 20),
            Text(
              'Task Date : ${_selectedDate != null ? _selectedDate.toString() : 'No Task Date Selected'}',
              style: const TextStyle(fontSize: 20, color: Colors.indigo),
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
              style: ElevatedButton.styleFrom(minimumSize: Size(350, 50)),
              child: Text('Choose Task Time', style: const TextStyle(color: Colors.indigo)),
            ),
            SizedBox(height: 30),
            Text("How Long ?", style: TextStyle(fontSize: 20, color: Colors.indigo)),
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
                    Task newTask = Task(
                      taskName: _taskController.text,
                      taskDate: _selectedDate!,
                      taskTime: _taskTime?.format(context),
                      duration: _duration,
                    );
                    Navigator.pop(context, newTask);
                  }
                },
                child: Text(
                  "Create Task",
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          EditTaskScreen(title: 'Edit Task',)));
                },
                child: Text(
                  "Edit",style: TextStyle(color: Colors.indigo),),)
            ]),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String taskName;
  final DateTime taskDate;
  final String? taskTime;
  final int? duration;
  Task({
    required this.taskName,
    required this.taskDate,
    this.taskTime,
    this.duration,
  });
}