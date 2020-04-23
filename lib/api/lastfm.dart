import 'dart:convert';

import 'package:http/http.dart';
import 'package:musicorum_app/api/structures/artist.dart';
import 'package:musicorum_app/api/structures/track.dart';
import 'package:musicorum_app/api/structures/types.dart';
import 'package:musicorum_app/api/structures/artist.dart';
import 'package:musicorum_app/constants.dart';

class LastfmApi {
  Future<Response> request(
      String method, Map<String, String> parameters) async {
    parameters['method'] = method;
    parameters['api_key'] = API_KEY;
    parameters['format'] = 'json';
    final url = Uri.https(LASTFM_API_URL, '/2.0/', parameters);
    print('making request');
    return get(url);
  }

  Future<List<ChartArtist>> getTopArtists(String user, Period period) async {
    final Map<String, String> parameters = new Map();
    parameters['user'] = user;
    parameters['period'] = period.value;

    final Response response = await request('user.getTopArtists', parameters);

    if (response.statusCode == 200 && response.body != null) {
      final json = jsonDecode(response.body);
      final List<dynamic> artistList = json['topartists']['artist'];
      List<ChartArtist> artists = [];
      for (int i = 0; i < artistList.length; i++) {
        artists.add(ChartArtist.fromJSON(artistList[i]));
      }
      return artists;
    } else {
      int code = response.statusCode;
      print('Error on API: Error code $code');
      throw Error();
    }
  }

  Future<List<ScrobbleTrack>> getRecentTracks(String user, int limit) async {
    final Map<String, String> parameters = new Map();
    parameters['user'] = user;
    parameters['limit'] = limit.toString();
    parameters['extended'] = '1';

    final Response response = await request('user.getRecentTracks', parameters);

    if (response.statusCode == 200 && response.body != null) {
      final json = jsonDecode(response.body);
      print('tracks');
      print(response.body);
      final List<dynamic> trackList = json['recenttracks']['track'];
      List<ScrobbleTrack> tracks = [];
      for (int i = 0; i < trackList.length; i++) {
        tracks.add(ScrobbleTrack.fromJSON(trackList[i]));
      }
      return tracks;
    } else {
      int code = response.statusCode;
      print('Error on API: Error code $code');
      throw Error();
    }
  }

  // TODO: lang
  Future<InfoArtist> getArtist(String name, String user) async {
    final Map<String, String> parameters = new Map();
    parameters['username'] = user;
    parameters['artist'] = name;

    final Response response = await request('artist.getInfo', parameters);

    if (response.statusCode == 200 && response.body != null) {
      final json = jsonDecode(response.body);
      print('artist');
      print(response.body);
      return InfoArtist.fromJSON(json['artist']);
    } else {
      int code = response.statusCode;
      print('Error on API: Error code $code');
      throw Error();
    }
  }

  Future<InfoTrack> getTrack(String name, String artist, String user) async {
    final Map<String, String> parameters = new Map();
    parameters['track'] = name;
    parameters['username'] = user;
    parameters['artist'] = artist;

    final Response response = await request('track.getInfo', parameters);

    if (response.statusCode == 200 && response.body != null) {
      final json = jsonDecode(response.body);
      print('artist');
      print(response.body);
      return InfoTrack.fromJSON(json['track']);
    } else {
      int code = response.statusCode;
      print('Error on API: Error code $code');
      throw Error();
    }
  }
}
