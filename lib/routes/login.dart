import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:musicorum_app/constants.dart';
import 'package:musicorum_app/styles/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void login() async {
    final result = await FlutterWebAuth.authenticate(
        url: API_URL + '/login?callback=musicorum://authCallback', callbackUrlScheme: 'musicorum');

    print(result);
    final token =  Uri.parse(result).queryParameters['token']
    final storage = FlutterSecureStorage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'To use the musicorum app, please log in with your last.fm account.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: 250,
                height: 50,
                child: MaterialButton(
                    onPressed: login,
                    color: musicorumRed,
                    child: Text(
                      'Log in with Last.fm',
                      style: TextStyle(fontSize: 23),
                    )))
          ],
        ),
      ),
    );
  }
}
