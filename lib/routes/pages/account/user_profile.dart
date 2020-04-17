import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:musicorum_app/api/structures/user.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.user, this.recentTracks);

  final User user;
  final List<ScrobbleTrack> recentTracks;

  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserProfile> {
  final double avatarSize = 250;

  User user;
  String registered;
  DateFormat format;
  NumberFormat numberFormatter;

  final TextStyle statsStyle = TextStyle(fontSize: 26);
  final TextStyle statsNameStyle = TextStyle(color: Colors.white70);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en');
    setState(() {
      user = widget.user;
      format = DateFormat.yMMMd('en');
      numberFormatter = NumberFormat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(avatarSize),
            child: Image.network(
              user.getImage(avatarSize.floor()),
              height: avatarSize,
              width: avatarSize,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              user.name,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Text('@' + user.username,
                style: TextStyle(fontSize: 16, color: Colors.white70))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: <Widget>[
              Spacer(),
              Column(
                children: <Widget>[
                  Text(
                    'Playcount',
                    style: statsNameStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    numberFormatter.format(user.playCount),
                    style: statsStyle,
                  )
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  Text(
                    'Scrobbling since',
                    style: statsNameStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    format.format(user.getRegisteredDate()),
                    style: statsStyle,
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}