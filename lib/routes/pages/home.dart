import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/controllers/navigation/destinations.dart';

class HomePage extends StatelessWidget {
  HomePage(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('fala, ${user.username}'),
      ),
    );
  }
}