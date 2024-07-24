import 'package:mottu_marvel/modules/home/data/exceptions/character_exception.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class CharacterDatasource {
  AsyncResult<List<CharacterMarvelEntity>, CharacterException> getCharacterList(
      FilterCharacterListDTO filters);
}
