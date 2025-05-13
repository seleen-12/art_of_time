import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Task.dart';
import '../Utils/clientConfig.dart';
import 'EditTaskScreen.dart';
import 'NewTaskScreen.dart';
import 'package:http/http.dart' as http;

class DateDetailScreen extends StatelessWidget {
  final DateTime selectedDate;

  DateDetailScreen({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Date Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: FutureBuilder(
        future: getTasks(selectedDate),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'No Tasks',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Task project = projectSnap.data[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            shadowColor: Colors.deepPurple.withOpacity(0.3),
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              tileColor: Colors.grey[100],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTaskScreen(title: 'Home Page'),
                                  ),
                                );
                              },
                              title: Text(
                                "Task ${project.statusID} :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              subtitle: Text(
                                project.taskName ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // New Task Button

                  ],
                ),
              );
            }
          } else if (projectSnap.hasError) {
            return Center(
              child: Text(
                'Error, try again',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
              strokeWidth: 4,
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTaskScreen(
                title: 'New Task',
                selectedDate: selectedDate,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'New Task',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future getTasks(selectedDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("token");
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    print("88");
    var url = "tasks/getTasks.php?userID=" + userID.toString() + "&date=" + formattedDate!.toString();
    print(serverPath + url);
    final response = await http.get(Uri.parse(serverPath + url));
    List<Task> arr = [];
    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Task.fromJson(i));
    }
    return arr;
  }
}