import 'package:flutter/material.dart';
import 'package:musicorum_app/api/structures/artist.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/routes/pages/track/track_info.dart';
import 'package:musicorum_app/styles/colors.dart';

class TrackPage extends StatefulWidget {
  TrackPage(this.track, this.user);

  @required
  final TrackBase track;
  final User user;

  @override
  State<StatefulWidget> createState() {
    return new TrackPageState();
  }
}

class TrackPageState extends State<TrackPage> {
  InfoTrack track;
  ArtistBase artist;
  String artistImage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final InfoTrack finalTrack = await widget.track.getFull(widget.user.username);
    final ArtistBase reqArtist = ArtistBase(name: finalTrack.artist);
    final String aImage = await reqArtist.getImageUrl(600);
    print(reqArtist.name);
    setState(() {
      track = finalTrack;
      artist = reqArtist;
      artistImage = aImage;
    });
    print(widget.track.getImage(250));
    print(finalTrack.getImage(250));
  }

  @override
  Widget build(BuildContext context) {
//    print(track.getImage(600));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0x44000000),
        title: Text(widget.track.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {return;},
          )
        ],
        bottom: artistImage == null ? LinearProgressIndicator(
          backgroundColor: whiteLoadingBackground,
          valueColor:
          AlwaysStoppedAnimation(Colors.white60),
        ) : Container(),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          child: extended.NestedScrollViewRefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        child: extended.NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Container(
                              height: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Color(0x56000000),
                                  Color(0x88000000),
                                  Color(0xff000000)
                                ],
                                begin: FractionalOffset.topCenter,
                                end: AlignmentDirectional.bottomCenter,
                              )),
                            ),
                          ),
                          artistImage != null
                              ? TrackInfo(track, artist, widget.track.getImage(300))
                              : Container()
                        ],
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(artistImage == null
                                ? widget.track.getImage(300)
                                : artistImage),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth),
                      ))
                ]))
              ];
            },
            body: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('TO-DO'),
                    Text(artist.toString()),
                    Text(track.toString()),
                  ],
                ),
              ],
            )),
      )),
    );
  }
}
