import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicorum_app/styles/colors.dart';

class LoggingIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: musicorumBlack,
        statusBarColor: new Color(0x00000000)
    ));

    return Scaffold(
      backgroundColor: musicorumBlack,
      body: Container(
        alignment: Alignment.center,
        child: Image(image: AssetImage('assets/icons/foreground-icon.png'))
      ),
    );
  }
}
/*
Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Padding(
              child: Text(
                'logging in...',
                style: TextStyle(fontSize: 19),
              ),
              padding: EdgeInsets.all(20),
            ),
            Container(
              width: 120,
              height: 4,
              child: LinearProgressIndicator(
                backgroundColor: whiteLoadingBackground,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          ],
        ),
  */