import 'dart:async';

import 'package:musicorum_app/api/deezer.dart';
import 'package:musicorum_app/api/lastfm.dart';
import 'package:musicorum_app/api/structures/artist.dart';
import 'package:musicorum_app/api/structures/tag.dart';
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

  Future<InfoTrack> getFull(String user) {
    LastfmApi lastfmApi = LastfmApi();
    return lastfmApi.getTrack(name, artist, user);
  }

  Future<InfoArtist> getArtist(String user) {
    LastfmApi lastfmApi = LastfmApi();
    return lastfmApi.getArtist(artist, user);
  }

  String toString() {
    return '{ Name: $name Artist $artist Album $album  }';
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
        album: json['album']['#text'],
        imageURL: images[3]['#text'],
        listenedTime: int.parse(json['date']['uts']),
        loved: json['loved'] == '1');
  }
}

class InfoTrack extends TrackBase {
  InfoTrack(
      {name,
      url,
      artist,
      album,
      imageURL,
      this.duration,
      this.loved,
      this.listeners,
      this.playCount,
      this.userPlaycount,
      this.tags})
      : super(
            name: name,
            url: url,
            artist: artist,
            album: album,
            imageURL: imageURL);

  // duration in Milliseconds
  final int duration;
  final int listeners;
  final int playCount;
  final int userPlaycount;
  final bool loved;
  final List<Tag> tags;

  @override
  Future<InfoTrack> getFull(String user) {
    return Future.value(this);
  }

  String toString() {
    return 'InfoTrack { name: $name, url: $url, artist: $artist, album: $album, loved: $loved, listeners: $listeners, playcount: $playCount, userPlayCount: $userPlaycount, tags: ${tags.map((e) => e.name)}  }';
  }

  factory InfoTrack.fromJSON(Map<String, dynamic> json) {
    final List images =
        json['album'] != null ? json['album']['image'] as List : null;
    final List tags = json['toptags']['tag'] as List;

    return InfoTrack(
      name: json['name'],
      url: json['url'],
      artist: json['artist']['name'],
      album: json['album'] != null ? json['album']['title'] : json['name'],
      imageURL: images == null ? null : images[3]['#text'],
      duration: int.parse(json['duration']),
      loved: json['userloved'] == '1',
      listeners: int.parse(json['listeners']),
      playCount: int.parse(json['playcount']),
      userPlaycount: int.parse(json['userplaycount']),
      tags: tags.map((e) => Tag.fromJSON(e)).toList(),
    );
  }
}
