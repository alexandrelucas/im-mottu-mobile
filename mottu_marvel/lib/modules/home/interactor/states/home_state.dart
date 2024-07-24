import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';

sealed class HomeState {
  const HomeState();

  factory HomeState.idle() {
    return const HomeIdleState();
  }

  factory HomeState.loading() {
    return const HomeLoadingState();
  }

  factory HomeState.error(String message) {
    return HomeErrorState(message);
  }
}

class HomeIdleState implements HomeState {
  const HomeIdleState();
}

class HomeLoadingState implements HomeState {
  const HomeLoadingState();
}

class HomeErrorState implements HomeState {
  final String message;
  const HomeErrorState(this.message);
}

class HomeSuccessfulFetchedState implements HomeState {
  final List<CharacterMarvelEntity> characters;

  const HomeSuccessfulFetchedState({
    required this.characters,
  });
}

class HomeCharacterListNoResultsState implements HomeState {
  const HomeCharacterListNoResultsState();
}
