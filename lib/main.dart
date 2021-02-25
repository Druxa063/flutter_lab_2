import 'package:flutter/material.dart';

import 'loginPage.dart';
import 'database.dart';
import 'homePage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        theme: ThemeData(
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
          ),
        ),
        home: LoginPage());
  }
}
