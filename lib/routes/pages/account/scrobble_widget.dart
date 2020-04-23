import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/styles/colors.dart';
import 'package:musicorum_app/routes/pages/track/track.dart';

class ScrobbleWidget extends StatelessWidget {
  ScrobbleWidget(this.track, this.user);

  final ScrobbleTrack track;
  final User user;
  final double imageSize = 38;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RawMaterialButton(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0x00ffffff)),
                borderRadius: BorderRadius.circular(3)),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 13),
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    track.getImage(60),
                    height: imageSize,
                    width: imageSize,
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        track.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        track.artist,
                        style: TextStyle(color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                track.loved
                    ? Positioned(
                  top: 20,
                  left: 20,
                  child: Icon(
                    Icons.favorite,
                    color: musicorumRed,
                  ),
                )
                    : Container()
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                  TrackPage(track, user)
              )
            );
          },
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Color(0x23ffffff),
          height: 2,
          thickness: 1.0,
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}