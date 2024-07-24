import 'package:mottu_marvel/modules/home/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/modules/home/data/datasources/character_local_datasource.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/repositories/characters_repository.dart';
import 'package:mottu_marvel/modules/home/interactor/states/home_state.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharacterDatasource datasource;
  final CharacterLocalDatasource localDatasource;

  CharactersRepositoryImpl(this.datasource, this.localDatasource);

  @override
  Future<HomeState> fetchCharactersList(FilterCharacterListDTO filters) async {
    final localCache = await localDatasource.getCharacterList(filters);

    if (localCache.isSuccess()) {
      datasource.getCharacterList(filters); // fetch and reload cache
      final characterList = localCache.getOrNull()!;

      if (characterList.isEmpty) {
        return const HomeCharacterListNoResultsState();
      }

      return HomeSuccessfulFetchedState(characters: characterList);
    }

    final result = await datasource.getCharacterList(filters);

    if (result.isError()) {
      return HomeErrorState(result.exceptionOrNull()!.message);
    }

    final characterList = result.getOrNull();

    if (characterList == null) {
      return const HomeErrorState("Erro ao capturar a lista de personagens");
    }

    if (characterList.isEmpty) {
      return const HomeCharacterListNoResultsState();
    }

    return HomeSuccessfulFetchedState(characters: characterList);
  }
}
