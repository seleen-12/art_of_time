import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/Task.dart';
import '../Utils/clientConfig.dart';
import 'EditTaskScreen.dart';

class DateDetailScreen extends StatelessWidget {
  final DateTime selectedDate;

  DateDetailScreen({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Date Details'),
        ),
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
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditTaskScreen(title: 'Home Page',)));
                                  },
                                  title: Text("Task " + project.statusID.toString() + " :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                  subtitle: Text(project.taskName!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
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
  }

  Future getTasks() async {
    var url = "tasks/getTasks.php";
    final response = await http.get(Uri.parse(serverPath + url));
    List<Task> arr = [];
    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Task.fromJson(i));
    }
    return arr;
  }
}