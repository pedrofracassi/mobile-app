import 'package:musicorum_app/api/deezer.dart';
import 'package:musicorum_app/constants.dart';

class TrackBase {
  TrackBase({this.name, this.url, this.artist, this.album, this.imageURL});

  final String name;
  final String url;
  final String artist;
  final String album;
  final String imageURL;

  String getImage(int size) {
    String url = DEFAULT_TRACK_IMAGE;
    if (this.imageURL != null || this.imageURL != "") url = this.imageURL;
    return url.replaceAll('300', size.toString());
  }
}

class ScrobbleTrack extends TrackBase {
  ScrobbleTrack(
      {name, url, artist, album, imageURL, this.listenedTime, this.loved})
      : super(
            name: name,
            url: url,
            artist: artist,
            album: album,
            imageURL: imageURL);

  final int listenedTime;
  final bool loved;

  DateTime getRegisteredDate() {
    return DateTime.fromMillisecondsSinceEpoch(this.listenedTime * 1000);
  }

  factory ScrobbleTrack.fromJSON(Map<String, dynamic> json) {
    final List images = json['image'] as List;

    return ScrobbleTrack(
        name: json['name'],
        url: json['url'],
        artist: json['artist']['name'],
        album: json['album']['name'],
        imageURL: images[3]['#text'],
        listenedTime: int.parse(json['date']['uts']),
        loved: json['loved'] == '1');
  }
}
