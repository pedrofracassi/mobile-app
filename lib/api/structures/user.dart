import 'package:musicorum_app/api/structures/artist.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'file:///D:/Projects/Musicorum/musicorumapp-flutter/musicorum_app/lib/api/lastfm.dart';
import 'package:musicorum_app/api/structures/types.dart';
import 'package:musicorum_app/constants.dart';

class User {
  User(this.playCount, this.name, this.username, this.url, this.country,
      this.imageURL, this.registered);

  final int playCount;
  final name;
  final username;
  final url;
  final country;
  final String imageURL;
  final int registered;

  DateTime getRegisteredDate() {
    return DateTime.fromMillisecondsSinceEpoch(this.registered * 1000);
  }

  String getImage(int size) {
    String url = DEFAULT_AVATAR_IMAGE;
    if (this.imageURL != null || this.imageURL != "") url = this.imageURL;
    return url.replaceAll('300', size.toString());
  }

  Future<List<ScrobbleTrack>> getRecentTracks ({limit}) async {
    if (limit == null) limit = 10;
    final LastfmApi lastfmApi = LastfmApi();
    return await lastfmApi.getRecentTracks(username, limit);
  }

  Future<List<ChartArtist>> getTopArtists (Period period) async {
    final LastfmApi lastfmApi = LastfmApi();
    return await lastfmApi.getTopArtists(username, period);
  }

  factory User.fromJSON(Map<String, dynamic> json) {
    final List images = json['image'] as List;

    return User(
        int.parse(json['playcount']),
        json['realname'],
        json['name'],
        json['url'],
        json['country'],
        images[3]['#text'],
        int.parse(json['registered']['unixtime'])
    );
  }


}