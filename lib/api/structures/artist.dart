import 'package:musicorum_app/api/deezer.dart';
import 'package:musicorum_app/api/structures/tag.dart';

class ArtistBase {
  ArtistBase({this.name, this.url});

  final String name;
  final String url;

  Future<String> getImageUrl(int size) async {
    DeezerApi deezerApi = DeezerApi();
    final String url = await deezerApi.getArtistImage(name);
    return url.replaceAll('250x250-000', '${size}x$size-000');
  }

  factory ArtistBase.fromJSON(Map<String, dynamic> json) {
    return ArtistBase(name: json['name'], url: json['url']);
  }
}

class ChartArtist extends ArtistBase {
  ChartArtist({this.rank, name, url, this.playCount})
      : super(name: name, url: url);

  final int rank;
  final int playCount;

  factory ChartArtist.fromJSON(Map<String, dynamic> json) {
    final List images = json['image'] as List;

    return ChartArtist(
        rank: int.parse(json['@attr']['rank']),
        name: json['name'],
        url: json['url'],
        playCount: int.parse(json['playcount']));
  }
}

class InfoArtist extends ArtistBase {
  InfoArtist(
      {name,
      url,
      this.stats,
      this.similar,
      this.tags,
      this.summaryBio,
      this.fullBio,
      this.bioPublished})
      : super(name: name, url: url);

  final ArtistStats stats;
  final List<ArtistBase> similar;
  final List<Tag> tags;
  final String summaryBio;
  final String fullBio;
  final String bioPublished;

  factory InfoArtist.fromJSON(Map<String, dynamic> json) {
    final List similar = json['similar']['artist'] as List;
    final List tags = json['tags']['tag'] as List;

    return InfoArtist(
      name: json['name'],
      url: json['url'],
      stats: ArtistStats.fromJSON(json['stats']),
      similar: similar.map((e) => ArtistBase.fromJSON(e)).toList(),
      tags: tags.map((e) => Tag.fromJSON(e)).toList(),
      summaryBio: json['bio']['summary'],
      fullBio: json['bio']['content'],
      bioPublished: json['bio']['published'],
    );
  }

  String toString() {
    return 'InfoArtist { name: $name, url: $url, stats: $stats, similar: ${similar.map((e) => e.name)} (${similar.length}), tags: ${tags.map((e) => e.name)} (${tags.length}), summaryBio: $summaryBio }';
  }
}

class ArtistStats {
  ArtistStats({this.listeners, this.plays, this.userPlayCount});

  final int listeners;
  final int plays;
  final int userPlayCount;

  String toString() {
    return 'ArtistStats { listeners: $listeners, plays: $plays, userPlayCount: $userPlayCount }';
  }

  factory ArtistStats.fromJSON(Map<String, dynamic> json) {
    return ArtistStats(
        listeners: int.parse(json['listeners']),
        userPlayCount: int.parse(json['userplaycount']),
        plays: int.parse(json['playcount']));
  }
}
