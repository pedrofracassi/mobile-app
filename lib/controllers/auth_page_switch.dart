import 'package:flutter/material.dart';
import 'package:musicorum_app/routes/login.dart';

class PageSwitch extends StatelessWidget {
  PageSwitch({Key key, this.authenticated}) : super(key: key);
  
  final bool authenticated;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: authenticated ? Text('logged') : LoginPage(),
    );
  }
}