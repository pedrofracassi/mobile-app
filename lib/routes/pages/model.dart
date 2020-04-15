import 'package:flutter/material.dart';

class PageModel extends StatelessWidget {
  PageModel({this.title, this.children});

  final String title;
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(
//              title,
//              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//            ),
//            SizedBox(
//              height: 20,
//            ),
            children
          ],
        ),
      ),
    );
  }
}
