import 'package:flutter/material.dart';

const List<int> list = <int>[1,5,10,15,30,45,60];

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<EditTaskScreen> createState() => HomePagePageState();
}

class HomePagePageState extends State<EditTaskScreen> {

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
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text("The Task :", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              SizedBox(height: 20,),
              Container(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Task',
                    ),
                  )
              ),
              SizedBox(height: 30,),
              Text("When ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(minimumSize: Size(350,50)
                ),
                child: const Text('Select Your Task Date',
                    style: TextStyle(color: Colors.indigo)),
              ),
              const SizedBox(height: 20),
              Text(
                'Task Date : ${_selectedDate != null ? _selectedDate.toString() : 'No Task Date Selected'}',
                style: const TextStyle(fontSize: 20, color: Colors.indigo),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Picked Time: ${picked.format(context)}',style: TextStyle(color: Colors.indigo),)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(350,50),
                ),
                child: Text('Choose Task Time', style: const TextStyle( color: Colors.indigo),),
              ),
              SizedBox(height: 30,),
              Text("How Long ?", style: TextStyle(fontSize: 20,color: Colors.indigo) ),
              SizedBox(height: 20,),
              DropdownMenu<int>(
                width: 350,
                initialSelection: list.first,
                onSelected: (int? value) {
                  setState(() {
                    var dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                list.map<DropdownMenuEntry<int>>((int value) {
                  return DropdownMenuEntry<int>(value: value, label: value.toString());
                }).toList(),
              ),
              SizedBox(height: 30,),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Update Task",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}