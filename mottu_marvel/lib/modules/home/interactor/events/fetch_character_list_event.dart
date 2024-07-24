import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';

sealed class CharacterListEvent {
  const CharacterListEvent();
}

class FetchCharacterListEvent implements CharacterListEvent {
  final FilterCharacterListDTO filters;
  const FetchCharacterListEvent(this.filters);
}

class FetchMoreCharacterListEvent implements CharacterListEvent {
  final FilterCharacterListDTO filters;
  const FetchMoreCharacterListEvent(this.filters);
}
