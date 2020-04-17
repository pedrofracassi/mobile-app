import 'package:musicorum_app/api/deezer.dart';

class ArtistBase {
  ArtistBase({this.name, this.url, this.playCount});

  final String name;
  final String url;
  final int playCount;

  Future<String> getImageUrl(int size) async {
    DeezerApi deezerApi = DeezerApi();
    final String url = await deezerApi.getArtistImage(name);
    return url.replaceAll('250x250-000', '${size}x$size-000');
  }
}

class ChartArtist extends ArtistBase {
  ChartArtist({this.rank, name, url, playCount})
      : super(name: name, url: url, playCount: playCount);

  final int rank;

  factory ChartArtist.fromJSON(Map<String, dynamic> json) {
    final List images = json['image'] as List;

    return ChartArtist(
        rank: int.parse(json['@attr']['rank']),
        name: json['name'],
        url: json['url'],
        playCount: int.parse(json['playcount']));
  }
}
