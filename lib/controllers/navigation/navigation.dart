import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/controllers/navigation/destinations.dart';
import 'package:musicorum_app/routes/pages/account.dart';
import 'package:musicorum_app/routes/pages/home.dart';

class DestinationView extends StatefulWidget {
  const DestinationView(
      { Key key, this.destination, this.user, this.onNavigation })
      : super(key: key);
  final Destination destination;
  final User user;
  final VoidCallback onNavigation;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
//    return Navigator(
//        observers: <NavigatorObserver>[
//          ViewNavigatorObserver(widget.onNavigation),
//        ],
//        onGenerateRoute: (RouteSettings settings) {
//          return MaterialPageRoute(
//            settings: settings,
//            builder: (BuildContext context) {
//              switch
//            }
//          )
//        }
//
//    );
/*
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return HomePage(widget.destination, widget.user);
              case '/account':
                return AccountPage(widget.destination, widget.user);
              default:
                return Text('404');
            }
          }
        );
      },
    );*/
  }
}

class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver(this.onNavigation);

  final VoidCallback onNavigation;

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }

  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
}