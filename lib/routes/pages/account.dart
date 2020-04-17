import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicorum_app/routes/pages/account/user_bottom_information.dart';
import 'package:musicorum_app/routes/pages/account/user_profile.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:musicorum_app/api/structures/types.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/routes/pages/model.dart';
import 'package:musicorum_app/styles/colors.dart';

class AccountPage extends StatefulWidget {
  AccountPage(this.user);

  final User user;

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with AutomaticKeepAliveClientMixin {
  bool checked = false;
  bool loaded = false;
  String artistImage;
  List<ScrobbleTrack> recentTracks;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    setState(() {
      loaded = false;
    });
    getArtistImage();
    super.initState();
  }

  Future<Null> getArtistImage() async {
//    _refreshIndicatorKey.currentState.deactivate();
    final artists = await widget.user.getTopArtists(Period.DAYS7);
    print(artists[0]);
    final newArtistImage = await artists[0].getImageUrl(700);
    final newRecentTracks = await widget.user.getRecentTracks(limit: 20);
    setState(() {
      loaded = true;
      artistImage = newArtistImage;
      recentTracks = newRecentTracks;
    });
//    _refreshIndicatorKey.currentState.show();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0x00ffffff),
        title: Text('Account'),
      ),
      body: DefaultTabController(
        length: 2,
        child: RefreshIndicator(
          onRefresh: getArtistImage,
          key: _refreshIndicatorKey,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: <Widget>[
                        !loaded
                            ? SafeArea(
                          top: true,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: LinearProgressIndicator(
                                  backgroundColor: whiteLoadingBackground,
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.white60),
                                ),
                                height: 3,
                              ),
                              UserProfile(widget.user, recentTracks)
                            ],
                          ),
                        )
                            : Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
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
                                PageModel(
                                    title: 'My Account',
                                    children: UserProfile(
                                        widget.user, recentTracks))
                              ],
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(artistImage),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fitWidth),
                            ))
                      ],
                    ),
                  ]),
                )
              ];
            },
            physics:
            AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            body: Column(
              children: <Widget>[
                TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: 'Last Scrobbles',
                      icon: Icon(Icons.queue_music),
                    ),
                    Tab(
                      text: 'Charts',
                      icon: Icon(Icons.show_chart),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      recentTracks != null
                          ? Container(
                        child: UserBottomInformation(
                            widget.user, recentTracks),
                      )
                          : Text('ue'),
                      Text('pag 2')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    /*return Column(
      children: <Widget>[
        Container(
          child: artistImage == null
              ? SafeArea(
            top: true,
            child: LinearProgressIndicator(),
          )
              : Text(''),
        ),
        Container(
          decoration: artistImage == null
              ? BoxDecoration()
              : BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(artistImage))),
          child: PageModel(
              title: 'My Account',
              children: UserAccount(widget.user, recentTracks)),
        )
      ],
    );
    return PageModel(
        title: 'My Account', children: UserAccount(widget.user, recentTracks));*/
  }

  @override
  bool get wantKeepAlive => true;
}

/*
widget.recentTracks == null
            ? Container()
            : UserBottomInformation(user, widget.recentTracks),

 */
