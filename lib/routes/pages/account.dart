import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:musicorum_app/api/structures/types.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/routes/pages/model.dart';

class AccountPage extends StatefulWidget {
  AccountPage(this.user);

  final User user;

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool checked = false;
  String artistImage;

  @override
  void initState() {
    getArtistImage();
    super.initState();
  }

  void getArtistImage() async {
    final artists = await widget.user.getTopArtists(Period.MONTH1);
    print(artists[0]);
    final newArtistImage = await artists[0].getImageUrl();
    setState(() {
      artistImage = newArtistImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return artistImage == null
        ? PageModel(
        title: 'My Account',
        children: Column(
          children: <Widget>[
            LinearProgressIndicator(),
            UserAccount(widget.user)
          ],
        ))
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
                      colors: [Color(0x99000000), Color(0xff000000)],
                      begin: FractionalOffset.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      stops: [0.0, 0.9])),
            ),
            PageModel(
                title: 'My Account', children: UserAccount(widget.user))
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(artistImage),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth),
        ));
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
              title: 'My Account', children: UserAccount(widget.user)),
        )
      ],
    );
    return PageModel(title: 'My Account', children: UserAccount(widget.user));
  }
}

class UserAccount extends StatefulWidget {
  UserAccount(this.user);

  final User user;

  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final double avatarSize = 250;

  User user;
  String registered;
  DateFormat format;

  final TextStyle statsStyle = TextStyle(fontSize: 26);
  final TextStyle statsNameStyle = TextStyle(color: Colors.white70);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en');
    setState(() {
      user = widget.user;
      format = DateFormat.yMMMd('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                    user.playCount.toString(),
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
        )
      ],
    );
  }
}
