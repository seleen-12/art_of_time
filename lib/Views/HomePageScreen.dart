import 'package:flutter/material.dart';
import 'package:art_of_time/Utils/DB.dart';
import '../Models/Task.dart';
import '../Utils/Utils.dart';
import 'EditProfileScreen.dart';
import 'EditTaskScreen.dart';
import 'HelpPageScreen.dart';
import 'NewTaskScreen.dart';

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

  // حساب الأيام في الشهر الحالي
  void _updateCalendar(DateTime date) {
    _daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    _firstDayOfMonth = DateTime(date.year, date.month, 1).weekday;
  }

  // تغيير الشهر للأمام أو للخلف
  void _changeMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta, 1);
      _updateCalendar(_currentMonth);
    });
  }

  // بناء الأيام في الشبكة
  List<Widget> _buildDaysGrid() {
    List<Widget> dayWidgets = [];

    // إضافة خلايا فارغة قبل بداية الشهر
    for (int i = 0; i < _firstDayOfMonth - 1; i++) {
      dayWidgets.add(Container());
    }

    // إضافة الأيام الفعلية في الشهر
    for (int day = 1; day <= _daysInMonth; day++) {
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            // عند الضغط على يوم معين، افتح صفحة جديدة لعرض التاريخ
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

          // عرض التقويم
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
          // استخدام Expanded لتجنب مشاكل التمرير
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true, // Prevent overflow in the grid
              physics: NeverScrollableScrollPhysics(), // Prevent scrolling
              children: _buildDaysGrid(),
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة لعرض التفاصيل عند الضغط على يوم من الأيام
class DateDetailScreen extends StatelessWidget {
  final DateTime selectedDate;

  DateDetailScreen({required this.selectedDate});

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
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewTaskScreen(
                      title: 'Create New Task',
                      selectedDate: selectedDate,
                    ),
                  ),
                );
              },
              child: Text("+", style: TextStyle(color: Colors.black)),
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

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now(); // إذا لم يكن هناك تاريخ محدد، استخدم التاريخ الحالي
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
                onPressed: () {},
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
