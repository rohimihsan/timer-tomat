import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Welcome to home',
        style: TextStyle(color: Colors.grey)),
      ),
      backgroundColor: Color(0xffF4F0BB),
    );
  }
}