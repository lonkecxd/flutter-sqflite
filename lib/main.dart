import 'package:flutter/material.dart';
import 'package:sqflite_demo/pages/home_page.dart';
import 'package:sqflite_demo/pages/login/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  var routes = {
    '/login': (BuildContext context) => new LoginPage(),
    '/home': (BuildContext context) => new HomePage(),
    '/': (BuildContext context) => new LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
        return new MaterialApp(
          title: 'Sqflite App',
          theme: ThemeData(primarySwatch: Colors.teal),
          routes: routes,
        );
  }
}
