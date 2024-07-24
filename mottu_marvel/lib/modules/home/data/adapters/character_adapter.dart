import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';

class CharacterListAdapter {
  static List<CharacterMarvelEntity> fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return List.from(
      data['results'].map((v) => CharacterAdapter.fromJson(v)),
    );
  }
}

class CharacterAdapter {
  static CharacterMarvelEntity fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    final fullThumbnailPath = "${thumbnail['path']}.${thumbnail['extension']}";

    return CharacterMarvelEntity(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      thumbnail: fullThumbnailPath,
    );
  }
}
