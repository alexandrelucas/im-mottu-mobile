import 'package:mottu_marvel/modules/home/data/adapters/character_adapter.dart';
import 'package:mottu_marvel/modules/home/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/modules/home/data/exceptions/character_exception.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';
import 'package:mottu_marvel/shared/exceptions/http_client_exception.dart';
import 'package:mottu_marvel/shared/services/http/http_client_service.dart';
import 'package:result_dart/result_dart.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final HttpClientService httpClient;

  CharacterDatasourceImpl(this.httpClient);

  @override
  AsyncResult<List<CharacterMarvelEntity>, CharacterException> getCharacterList(
      FilterCharacterListDTO filters) async {
    try {
      final response =
          await httpClient.get('/characters', queryParameters: filters.toMap());
      final entity = CharacterListAdapter.fromJson(response.data);
      return Success(entity);
    } on HttpClientException catch (error) {
      return Failure(CharacterException(error.message ?? ''));
    }
  }
}
