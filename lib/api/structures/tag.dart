import 'package:flutter/material.dart';

class Tag {
  Tag({this.name, this.url});

  @required
  final String name;
  @required
  final String url;

  factory Tag.fromJSON(Map<String, dynamic> json) {
    return Tag(
        name: json['name'],
        url: json['url']
    );
  }
}
