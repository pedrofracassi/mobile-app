import 'package:flutter/material.dart';
import 'package:musicorum_app/routes/pages/account/scrobble_widget.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:musicorum_app/api/structures/user.dart';

class UserBottomInformation extends StatelessWidget {
  UserBottomInformation(this.user, this.recentTracks);

  final User user;
  final List<ScrobbleTrack> recentTracks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Last Scrobbles',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: 14,
              ),
              ...recentTracks
                  .map((ScrobbleTrack t) => ScrobbleWidget(t))
                  .toList()
            ],
          ),
        ),
      ],
    );
  }
}
