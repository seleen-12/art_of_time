import 'dart:convert';

import 'package:art_of_time/Views/EditTaskScreen.dart';
import 'package:flutter/material.dart';
import '../Models/Task.dart';
import '../Utils/clientConfig.dart';
import 'EditProfileScreen.dart';
import 'HelpPageScreen.dart';
import 'NewTaskScreen.dart';
import 'package:http/http.dart' as http;

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
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
      //         style: TextStyle(fontSize: 30),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () async {
      //           final newTask = await Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => NewTaskScreen(
      //                 title: 'Create New Task',
      //                 selectedDate: widget.selectedDate,
      //               ),
      //             ),
      //           );
      //
      //           if (newTask != null) {
      //             _addTask(newTask);
      //           }
      //         },
      //         child: Text("+", style: TextStyle(color: Colors.black)),
      //       ),
      //       SizedBox(height: 20),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: tasks.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text('Task ${index + 1}: ${tasks[index].taskName}'),  // إضافة الرقم التسلسلي هنا
      //               subtitle: Text(
      //                   'Date: ${tasks[index].taskDate.toString()} | Time: ${tasks[index].taskTime ?? "Not Set"} | Duration: ${tasks[index].duration != null ? "${tasks[index].duration} min" : "Not Set"}'),
      //             );
      //           },
                  body: FutureBuilder(
                    future: getTasks(),
                    builder: (context, projectSnap) {
                      if (projectSnap.hasData) {
                        if (projectSnap.data.length == 0)
                        {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 2,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('אין תוצאות', style: TextStyle(fontSize: 23, color: Colors.black))
                            ),
                          );
                        }
                        else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              Expanded(
                                  child:ListView.builder(
                                    itemCount: projectSnap.data.length,
                                    itemBuilder: (context, index) {
                                      Task project = projectSnap.data[index];


                                      return Card(
                                          child: ListTile(
                                            // enabled: false,
                                            onTap: () {

                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditTaskScreen(title: 'Home Page',)));

                                            },
                                            title: Text(project.taskName!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),), // Icon(Icons.timer),
                                            subtitle: Text("" + project.statusID.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                           /*
                                            trailing: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              child: Text(
                                                project.totalHours!,   // + "שעות "
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                              ),
                                            ),
*/

                                            isThreeLine: false,
                                          ));
                                    },
                                  )),
                            ],
                          );
                        }
                      }
                      else if (projectSnap.hasError)
                      {
                        return  Center(child: Text('שגיאה, נסה שוב', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
                      }
                      return Center(child: new CircularProgressIndicator(color: Colors.red,));
                    },
                  )
              );
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }








  Future getTasks() async {

    var url = "tasks/getTasks.php";
    final response = await http.get(Uri.parse(serverPath + url));
    // print(serverPath + url);
    List<Task> arr = [];

    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Task.fromJson(i));
    }

    return arr;
  }

}
