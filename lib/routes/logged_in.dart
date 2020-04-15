import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/controllers/navigation/destination.dart';
import 'package:musicorum_app/controllers/navigation/navigation.dart';
import 'package:musicorum_app/routes/pages/account.dart';
import 'package:musicorum_app/routes/pages/home.dart';
import 'package:musicorum_app/styles/colors.dart';

class LoggedInRoute extends StatefulWidget {
  const LoggedInRoute(this.user);

  final User user;

  _LoggedInRouteState createState() => _LoggedInRouteState();
}

class _LoggedInRouteState extends State<LoggedInRoute> {
  int _pageIndex = 0;
  List<Widget> _pages;

  @override
  void initState() {
    setState(() {
      _pages = <Widget>[
        new HomePage(widget.user),
        new HomePage(widget.user),
        new HomePage(widget.user),
        new AccountPage(widget.user),
        new AccountPage(widget.user)
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.black87));

    return Scaffold(
      body: SafeArea(
          top: false,
          child: _pages[_pageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavColor,
        currentIndex: _pageIndex,
        onTap: (int index) => {
          setState(() {
            _pageIndex = index;
          })
        },
        items: destinations
            .map((Destination destination) => BottomNavigationBarItem(
                icon: Icon(destination.icon), title: Text(destination.title)))
            .toList(),
      ),
    );
  }
}
