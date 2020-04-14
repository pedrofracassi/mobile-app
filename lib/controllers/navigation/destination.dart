import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> destinations = <Destination>[
  Destination('Feed', Icons.home),
  Destination('Discover', Icons.search),
  Destination('Charts', Icons.show_chart),
];