import 'dart:convert';

import 'package:mottu_marvel/modules/home/data/adapters/character_adapter.dart';
import 'package:mottu_marvel/modules/home/data/datasources/character_local_datasource.dart';
import 'package:mottu_marvel/modules/home/data/exceptions/character_exception.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';
import 'package:mottu_marvel/shared/services/local_storage/local_storage_service.dart';
import 'package:result_dart/result_dart.dart';

class CharacterLocalDatasourceImpl implements CharacterLocalDatasource {
  final LocalStorageService localStorageService;

  CharacterLocalDatasourceImpl(this.localStorageService);

  @override
  AsyncResult<List<CharacterMarvelEntity>, CharacterException> getCharacterList(
      FilterCharacterListDTO filters) async {
    // Load from Local Cache
    final urlPath =
        '${const String.fromEnvironment('BASE_URL')}/characters?$filters';

    final cacheExists = await localStorageService.contains(urlPath);

    if (!cacheExists) {
      return const Failure(CharacterException("Character not found on cache"));
    }

    final result = await localStorageService.get(urlPath);

    if (result.isEmpty) {
      return const Failure(CharacterException("Character not found on cache"));
    }

    final encodedData = jsonDecode(result);

    final entity = CharacterListAdapter.fromJson(encodedData);
    return Success(entity);
  }
}
