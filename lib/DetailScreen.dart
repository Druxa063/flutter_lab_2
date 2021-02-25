import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_lab_2/EditScreen.dart';
import 'package:image_picker/image_picker.dart';

import 'note.dart';

class DetailScreen extends StatefulWidget {
  Note note;

  DetailScreen({Key key, @required this.note}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isUpdate = false;

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        widget.note.attachment = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  widget.note.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Center(
                    child: Container(
                  margin: EdgeInsets.all(5),
                  height: height * 0.25,
                  child: widget.note.attachment == null
                      ? RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black12)),
                      padding: EdgeInsets.all(12.0),
                      child: Text("Upload Image"),
                      onPressed: getImage)
                      : Image.file(
                          widget.note.attachment,
                          fit: BoxFit.fill,
                        ),
                )),
                Row(
                  children: [
                    Text(
                      "Description: ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(widget.note.description),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Priority: ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(widget.note.priority),
                    widget.note.showIcon(context),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Date: ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(widget.note.date.toIso8601String()),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)),
                            padding: EdgeInsets.all(7.0),
                            child: Text("Back"),
                            onPressed: () async {
                              await Navigator.pop(context);
                            }),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)),
                            padding: EdgeInsets.all(7.0),
                            child: Text("Edit note"),
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditScreen(note: widget.note)));
                              setState(() {
                                isUpdate = true;
                              });
                            }),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)),
                            padding: EdgeInsets.all(7.0),
                            child: Text("Upload Image"),
                            onPressed: getImage),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
