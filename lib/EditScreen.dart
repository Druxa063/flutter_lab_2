import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_lab_2/user.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'homePage.dart';
import 'note.dart';

class EditScreen extends StatefulWidget {
  Note note;
  User user;

  EditScreen({Key key, @required this.note, @required this.user}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String priority = 'normal';
  final _formKey = GlobalKey<FormState>();

  void _save(Note item) async {
    await DB.insert(Note.table, item);
    setState() {}
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.note.name,
                    decoration: InputDecoration(
                      labelText: "Name:",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      widget.note.name = text;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.note.date.day.toString() +
                        "-" +
                        widget.note.date.month.toString() +
                        "-" +
                        widget.note.date.year.toString(),
                    decoration: InputDecoration(
                      labelText: "Date:",
                      hintText: 'dd-MM-yyyy',
                    ),
                    inputFormatters: [
                      new MaskTextInputFormatter(
                          mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')})
                    ],
                    onChanged: (text) {
                      if (text != null || text.length != 0) {
                        DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                        widget.note.date = dateFormat.parse(text);
                      } else {
                        widget.note.date = new DateTime.now();
                      }
                    },
                  ),
                  DropdownButton<String>(
                    value: widget.note.priority,
                    isExpanded: true,
                    isDense: false,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 22,
                    elevation: 2,
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        priority = newValue;
                        widget.note.priority = newValue;
                      });
                    },
                    items: <String>['low', 'normal', 'major', 'critical']
                        .map<DropdownMenuItem<String>>((String priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    initialValue: widget.note.description,
                    decoration: InputDecoration(
                        hintText: 'Enter a bucket description',
                        labelText: "Description"),
                    onChanged: (text) {
                      if (text != null || text.length != 0) {
                        widget.note.description = text;
                      } else {
                        widget.note.description = "";
                      }
                    },
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                          child: Text("Back"),
                          onPressed: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    user: widget.user,
                                  )),
                            );
                          }),
                      RaisedButton(
                        child: Text('Save'),
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            widget.note.setIcon();
                            Note note = new Note(
                                userName: widget.user.name,
                                name: widget.note.name,
                                description: widget.note.description,
                                priority: widget.note.priority,
                                date: widget.note.date);
                            _save(note);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
