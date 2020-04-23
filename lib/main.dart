import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:musicorum_app/api/musicorum.dart';
import 'package:musicorum_app/api/structures/user.dart' as UserObj;
import 'package:musicorum_app/constants.dart';
import 'package:musicorum_app/controllers/auth_page_switch.dart';
import 'package:musicorum_app/routes/logging_in.dart';
import 'package:musicorum_app/styles/colors.dart';
import 'package:sentry/io_client.dart';

final SentryClient sentry = new SentryClient(dsn: SENTRY_DSN);

void main() {
  runApp(MusicorumApp());
}

class MusicorumApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    try {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: primaryColor,
          scaffoldBackgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RootPage(),
      );
    } catch (error, stackTrace) {
      sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool loading = true;
  bool authenticated = false;
  String error;
  UserObj.User user;

  @override
  void initState() {
    log('Carregando');
    authDevice();
    super.initState();
  }

  Future authDevice() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: SECURE_STORAGE_TOKEN);
    if (token == null) {
      setState(() {
        loading = false;
        authenticated = false;
      });
      return;
    }
    try {
      MusicorumApi musicorumApi = MusicorumApi();
      UserObj.User resUser = await musicorumApi.getCurrentAccount(token);
      if (resUser != null) {
        print('${resUser.name} logged in.');
        setState(() {
          loading = false;
          authenticated = true;
          user = resUser;
        });
      } else {
        setState(() {
          loading = false;
          authenticated = true;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('aa'),
          content: Text(error),
        );
      });
    }
    log(loading.toString());
    return loading ? LoggingIn() : PageSwitch(authenticated: authenticated, onLogin: authDevice, user: user,);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
