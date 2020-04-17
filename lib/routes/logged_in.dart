import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/controllers/navigation/destinations.dart';
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
  List<Widget> pages;

  HomePage homePage;
  AccountPage accountPage;

  final PageController pageController = PageController();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    setState(() {
      pages = [
        HomePage(widget.user),
        AccountPage(widget.user),
        HomePage(widget.user),
        AccountPage(widget.user)
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: bottomNavColor));

    return Scaffold(
      body: PageView(
        children: pages,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (int index) => {
          pageController.jumpToPage(index)
        },
        items: destinations
            .map((Destination destination) => BottomNavigationBarItem(
                icon: Icon(destination.icon), title: Text(destination.title)))
            .toList(),
      ),
    );
  }
}
