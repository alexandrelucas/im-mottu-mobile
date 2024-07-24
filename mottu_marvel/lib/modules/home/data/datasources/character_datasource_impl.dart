import 'dart:convert';

import 'package:mottu_marvel/modules/home/data/adapters/character_adapter.dart';
import 'package:mottu_marvel/modules/home/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/modules/home/data/exceptions/character_exception.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';
import 'package:mottu_marvel/shared/exceptions/http_client_exception.dart';
import 'package:mottu_marvel/shared/services/http/http_client_service.dart';
import 'package:mottu_marvel/shared/services/local_storage/local_storage_service.dart';
import 'package:result_dart/result_dart.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final HttpClientService httpClient;
  final LocalStorageService localStorageService;

  CharacterDatasourceImpl(this.httpClient, this.localStorageService);

  @override
  AsyncResult<List<CharacterMarvelEntity>, CharacterException> getCharacterList(
      FilterCharacterListDTO filters) async {
    try {
      final response =
          await httpClient.get('/characters', queryParameters: filters.toMap());

      // Store the request into LocalStorage
      final urlPath =
          '${const String.fromEnvironment('BASE_URL')}/characters?$filters';
      final responseData = response.data;

      final encodedRequest = jsonEncode(responseData);
      localStorageService.put(urlPath, encodedRequest);

      final entity = CharacterListAdapter.fromJson(responseData);
      return Success(entity);
    } on HttpClientException catch (error) {
      return Failure(CharacterException(error.message ?? ''));
    }
  }
}
