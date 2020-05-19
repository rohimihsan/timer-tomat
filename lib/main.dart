import 'package:flutter/material.dart';
import 'package:timerTomat/timerScreen.dart';
import 'dart:async';

void main() => runApp(
  new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder> {
      '/TimerScreen' : (BuildContext context) => new TimerScreen()
    },
  ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration  = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/TimerScreen');
  }

  @override
  void initState(){
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        body: new Image.asset('images/timer_tomat.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,     
        ),
      );
  }
}