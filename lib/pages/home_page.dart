import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Center(
        child: Text('My Home'),
      ),
    );
  }
}
