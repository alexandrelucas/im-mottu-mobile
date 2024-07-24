import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/states/home_state.dart';

abstract interface class CharactersRepository {
  Future<HomeState> fetchCharactersList(FilterCharacterListDTO filters);
}
