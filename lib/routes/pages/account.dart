import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/controllers/navigation/destination.dart';

class AccountPage extends StatefulWidget {
  AccountPage(this.user);

  final User user;

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('CONTA DO ${widget.user.username}'),
            Switch(value: checked, onChanged: (value) => {
              setState(() {
                checked = value;
              })
            })
          ],
        ),
      ),
    );
  }
}