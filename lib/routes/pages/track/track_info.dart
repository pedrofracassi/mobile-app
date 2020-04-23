import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:musicorum_app/api/structures/artist.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:musicorum_app/api/structures/user.dart';

class TrackInfo extends StatefulWidget {
  TrackInfo(this.track, this.artist, this.trackImage);

  final InfoTrack track;
  final ArtistBase artist;
  final String trackImage;

  _TrackInfoState createState() => _TrackInfoState();
}

class _TrackInfoState extends State<TrackInfo> {
  final double avatarSize = 250;

  InfoTrack track;
  ArtistBase artist;
  String imageUrl;

  DateFormat format;
  NumberFormat numberFormatter;

  final TextStyle statsStyle = TextStyle(fontSize: 26);
  final TextStyle statsNameStyle = TextStyle(color: Colors.white70);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en');
    setState(() {
      track = widget.track;
      artist = widget.artist;
      format = DateFormat.yMMMd('en');
      numberFormatter = NumberFormat();
      imageUrl = widget.trackImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(track.toString());
    return Column(
      children: <Widget>[
        SizedBox(
          height: 270,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              imageUrl,
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
              track.name,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Text(track.artist,
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
                    'Total Playcount',
                    style: statsNameStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    numberFormatter.format(track.playCount),
                    style: statsStyle,
                  )
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  Text(
                    'Listeners',
                    style: statsNameStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    numberFormatter.format(track.listeners),
                    style: statsStyle,
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: <Widget>[
              Spacer(),
              Column(
                children: <Widget>[
                  Text(
                    'Your Playcount',
                    style: statsNameStyle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    numberFormatter.format(track.userPlaycount),
                    style: statsStyle,
                  )
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