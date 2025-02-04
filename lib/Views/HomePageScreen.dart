import 'package:flutter/material.dart';
import 'EditProfileScreen.dart';
import 'EditTaskScreen.dart';
import 'HelpPageScreen.dart';

const List<int> list = <int>[1, 5, 10, 15, 30, 45, 60];

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<HomePageScreen> {
  DateTime _currentMonth = DateTime.now();
  late int _daysInMonth;
  late int _firstDayOfMonth;

  @override
  void initState() {
    super.initState();
    _updateCalendar(_currentMonth);
  }

  void _updateCalendar(DateTime date) {
    _daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    _firstDayOfMonth = DateTime(date.year, date.month, 1).weekday;
  }

  void _changeMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta, 1);
      _updateCalendar(_currentMonth);
    });
  }

  List<Widget> _buildDaysGrid() {
    List<Widget> dayWidgets = [];

    for (int i = 0; i < _firstDayOfMonth - 1; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= _daysInMonth; day++) {
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DateDetailScreen(
                  selectedDate: DateTime(_currentMonth.year, _currentMonth.month, day),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
              color: _currentMonth.day == day ? Colors.blue : Colors.transparent,
            ),
            child: Text(
              '$day',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _currentMonth.day == day ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              print('?');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPageScreen(title: 'Help Page')),
              );
            },
            child: Text("?", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 70),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen(title: 'Edit Profile')),
              );
            },
            child: Icon(Icons.account_circle_rounded),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${_currentMonth.month} - ${_currentMonth.year}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _changeMonth(-1),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('الأحد'),
              Text('الإثنين'),
              Text('الثلاثاء'),
              Text('الأربعاء'),
              Text('الخميس'),
              Text('الجمعة'),
              Text('السبت'),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: _buildDaysGrid(),
            ),
          ),
        ],
      ),
    );
  }
}

class DateDetailScreen extends StatefulWidget {
  final DateTime selectedDate;

  DateDetailScreen({required this.selectedDate});

  @override
  _DateDetailScreenState createState() => _DateDetailScreenState();
}

class _DateDetailScreenState extends State<DateDetailScreen> {
  List<Task> tasks = [];

  void _addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل التاريخ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewTaskScreen(
                      title: 'Create New Task',
                      selectedDate: widget.selectedDate,
                    ),
                  ),
                );

                if (newTask != null) {
                  _addTask(newTask);
                }
              },
              child: Text("+", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index].taskName),
                    subtitle: Text('Date: ${tasks[index].taskDate.toString()}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Picked Time: ${picked.format(context)}', style: TextStyle(color: Colors.indigo))),
                  );
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
                  var dropdownValue = value!;
                });
              },
              dropdownMenuEntries: list.map<DropdownMenuEntry<int>>((int value) {
                return DropdownMenuEntry<int>(value: value, label: value.toString());
              }).toList(),
            ),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  if (_taskController.text.isNotEmpty && _selectedDate != null) {
                    Task newTask = Task(
                      taskName: _taskController.text,
                      taskDate: _selectedDate!,
                    );
                    Navigator.pop(context, newTask);
                  }
                },
                child: Text(
                  "Create Task",
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ]),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                print('Edit');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditTaskScreen(title: 'Edit Task')),
                );
              },
              child: Text('Edit Task', style: TextStyle(color: Colors.indigo)),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String taskName;
  final DateTime taskDate;

  Task({required this.taskName, required this.taskDate});
}