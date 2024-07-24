import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';
import 'package:mottu_marvel/modules/home/interactor/events/fetch_character_list_event.dart';
import 'package:mottu_marvel/modules/home/interactor/repositories/characters_repository.dart';
import 'package:mottu_marvel/modules/home/interactor/states/home_state.dart';

class CharacterBloc extends Bloc<CharacterListEvent, HomeState> {
  final CharactersRepository repository;

  CharacterBloc(this.repository) : super(const HomeIdleState()) {
    on<FetchCharacterListEvent>(_fetchList);
    on<FetchMoreCharacterListEvent>(_fetchMoreList);
  }

  void _fetchList(FetchCharacterListEvent event, emit) async {
    emit(const HomeLoadingState());
    final newState = await repository.fetchCharactersList(event.filters);
    emit(newState);
  }

  void _fetchMoreList(FetchMoreCharacterListEvent event, emit) async {
    final currentCharacterList = (state as dynamic).characters;
    emit(HomeGridLoadingState(currentCharacterList));
    final newState = await repository.fetchCharactersList(event.filters);

    if (newState is HomeSuccessfulFetchedState) {
      final List<CharacterMarvelEntity> newCharacterList = [];
      newCharacterList.addAll(currentCharacterList);
      newCharacterList.addAll(newState.characters);
      emit(HomeSuccessfulFetchedState(characters: newCharacterList));
    } else {
      emit(newState);
    }
  }
}
