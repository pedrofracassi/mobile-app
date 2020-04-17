import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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

class _AccountPageState extends State<AccountPage> {
  bool checked = false;
  bool loaded = false;
  String artistImage;
  List<ScrobbleTrack> recentTracks;

  @override
  void initState() {
    setState(() {
      loaded = false;
    });
    getArtistImage();
    super.initState();
  }

  void getArtistImage() async {
    final artists = await widget.user.getTopArtists(Period.DAYS7);
    print(artists[0]);
    final newArtistImage = await artists[0].getImageUrl(700);
    final newRecentTracks = await widget.user.getRecentTracks();
    setState(() {
      loaded = true;
      artistImage = newArtistImage;
      recentTracks = newRecentTracks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(0),
      children: <Widget>[
        !loaded
            ? SafeArea(
                top: true,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: LinearProgressIndicator(
                        backgroundColor: whiteLoadingBackground,
                        valueColor: AlwaysStoppedAnimation(Colors.white60),
                      ),
                      height: 5,
                    ),
                    UserAccount(widget.user, recentTracks)
                  ],
                ),
              )
            : Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0x88000000),
                          Color(0xaa000000),
                          Color(0xff000000)
                        ],
                        begin: FractionalOffset.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                      )),
                    ),
                    PageModel(
                        title: 'My Account',
                        children: UserAccount(widget.user, recentTracks))
                  ],
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(artistImage),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth),
                ))
      ],
    );
    return Column(
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
        title: 'My Account', children: UserAccount(widget.user, recentTracks));
  }
}

class UserAccount extends StatefulWidget {
  UserAccount(this.user, this.recentTracks);

  final User user;
  final List<ScrobbleTrack> recentTracks;

  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
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
        widget.recentTracks == null
            ? Container()
            : UserBottomInformation(user, widget.recentTracks),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

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

class ScrobbleWidget extends StatelessWidget {
  ScrobbleWidget(this.track);

  final ScrobbleTrack track;
  final double imageSize = 38;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                  track.getImage(imageSize.floor()),
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
