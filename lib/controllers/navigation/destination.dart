import 'package:flutter/material.dart';
import 'package:musicorum_app/routes/pages/home.dart';

class Destination {
  const Destination(this.title, this.id, this.icon);

  final String id;
  final String title;
  final IconData icon;
}

const List<Destination> destinations = <Destination>[
  Destination('Discover', 'discover', Icons.search),
  Destination('Charts', 'charts', Icons.show_chart),
  Destination('Scrobbling', 'scrobbling', Icons.queue_music),
  Destination('Account', 'account', Icons.person),
];