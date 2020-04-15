import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/routes/logged_in.dart';
import 'package:musicorum_app/routes/login.dart';

class PageSwitch extends StatelessWidget {
  PageSwitch({Key key, this.authenticated, this.onLogin, this.user}) : super(key: key);

  final Function onLogin;
  final bool authenticated;
  final User user;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: authenticated ? LoggedInRoute(user) : LoginPage(onLogin: onLogin),
    );
  }
}