import 'package:flutter/material.dart';
import 'package:musicorum_app/routes/pages/home.dart';

class Destination {
  const Destination(this.index, this.title, this.id, this.icon);

  final int index;
  final String id;
  final String title;
  final IconData icon;
}

const List<Destination> destinations = <Destination>[
  Destination(0, 'Discover', 'discover', Icons.search),
  Destination(1, 'Charts', 'charts', Icons.show_chart),
  Destination(2, 'Scrobbling', 'scrobbling', Icons.queue_music),
  Destination(3, 'Account', 'account', Icons.person),
];