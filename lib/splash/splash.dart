import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async{
    var _duration=new Duration(seconds: 2);
    return new Timer(_duration,navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('home/HomeScreen');
  }
}
