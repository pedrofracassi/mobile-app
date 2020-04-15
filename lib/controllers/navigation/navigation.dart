import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/controllers/navigation/destination.dart';
import 'package:musicorum_app/routes/pages/account.dart';
import 'package:musicorum_app/routes/pages/home.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({ Key key, this.destination, this.user }): super(key: key);
  final Destination destination;
  final User user;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
        text: 'text test'
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: fix this: not saving states
    switch (widget.destination.id) {
      case 'feed':
        return HomePage(widget.user);
      case 'account':
        return AccountPage(widget.user);
      default:
        return Text('404 - aaaaaaaaaa');
    }
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

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

class DestinationsController extends StatefulWidget {
  const DestinationsController({ Key key, this.user }): super(key: key);
  final User user;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}