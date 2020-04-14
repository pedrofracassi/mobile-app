import 'package:flutter/material.dart';
import 'package:musicorum_app/controllers/navigation/destination.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({ Key key, this.destination }): super(key: key);
  final Destination destination;

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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: Text('bom dia'),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}