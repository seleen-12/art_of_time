import 'package:flutter/material.dart';
import 'HomePageScreen.dart';

  class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.title});

  final String title;

  @override
  State<EditProfileScreen> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfileScreen> {
  get selectedDate => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
          ),
        )
    );
  }
}