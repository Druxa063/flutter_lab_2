import 'package:flutter/material.dart';

class NoteCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Text("test"),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter your username'),
          ),
        ]),
      ),
    );
  }
}
