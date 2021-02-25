import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_lab_2/database.dart';
import 'package:flutter_lab_2/user.dart';
import 'package:sqflite/sqflite.dart';
import 'DetailScreen.dart';
import 'EditScreen.dart';
import 'note.dart';

class HomePage extends StatefulWidget {
  User user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> noteList = List();
  Color _tileColor1 = Colors.black12;
  Color _tileColor2 = Colors.black54;

  void refresh() async {
    print(widget.user.name);
    List<Map<String, dynamic>> _results =
        await DB.query(Note.table, widget.user.name);
    setState(() {
      noteList = _results.map((item) => Note.fromJson(item)).toList();
    });
  }

  void _delete(Note item) async {
    DB.delete(Note.table, item);
    refresh();
  }

  void _save(Note item) async {
    await DB.insert(Note.table, item);
    setState() {}
    ;
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                  "Total number of notes " + (noteList.length).toString()),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // Let the ListView know how many items it needs to build.
                itemCount: noteList.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.

                itemBuilder: (context, index) {
                  final item = noteList[index];

                  return Container(
                      margin: EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          color: _tileColor1,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Dismissible(
                          key: Key(item.name),
                          onDismissed: (direction) {
                            setState(() {
                              noteList.removeAt(index);
                              _delete(item);
                              refresh();
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("$item is deleted"),
                              duration: Duration(seconds: 1),
                            ));
                          },
                          child: ListTile(
                              leading: (item.icon),
                              trailing: Text((item.getDate())),
                              title: Text(item.name),
                              subtitle: Text(item.description),
                              selectedTileColor: _tileColor2,
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            note: noteList[index])));
                                setState(() {});
                              })));
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.grey)),
                  padding: EdgeInsets.all(15.0),
                  child: Text("Add new note"),
                  onPressed: () async {
                    print(widget.user.name);
                    Note note = new Note(
                        userName: widget.user.name,
                        name: "name ${noteList.length}",
                        description: "",
                        date: DateTime.now());
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditScreen(note: note, user: widget.user)));
                    setState(() {
                      _save(note);
                      refresh();
                      noteList.add(note);
                      print(noteList);
                    });
                    print(noteList.length);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
