import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/constants/app_assets.dart';
import 'package:mottu_marvel/constants/app_colors.dart';
import 'package:mottu_marvel/modules/home/interactor/blocs/character_bloc.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/events/fetch_character_list_event.dart';
import 'package:mottu_marvel/modules/home/interactor/states/home_state.dart';
import 'package:mottu_marvel/modules/home/ui/widgets/filter_modal_widget.dart';
import 'package:mottu_marvel/modules/home/ui/widgets/grid_character_card_widget.dart';
import 'package:mottu_marvel/modules/home/ui/widgets/marvel_button_widget.dart';
import 'package:mottu_marvel/shared/extensions/context_extension.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final StreamSubscription blocStream;
  late final ScrollController scrollController;
  final filter = ValueNotifier(FilterCharacterListDTO(offset: 0));

  @override
  void initState() {
    super.initState();

    context.read<CharacterBloc>().add(
          FetchCharacterListEvent(
            filter.value,
          ),
        );

    // Watch Error State
    blocStream = context.read<CharacterBloc>().stream.listen((state) {
      if (state is HomeErrorState) {
        context.showSnackMessage(state.message);
      }

      if (state is HomeGridLoadingState) {
        context.showSnackMessage('Fetching more results...');
      }

      if (state is HomeSuccessfulFetchedState) {
        context.showSnackMessage('Data fetched successfully!');
      }
    });

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // get more

        if (context.read<CharacterBloc>().state is! HomeGridLoadingState) {
          filter.value = filter.value
              .copyWith(offset: filter.value.offset + filter.value.limit);
          context
              .read<CharacterBloc>()
              .add(FetchMoreCharacterListEvent(filter.value));
        }
      }
    });
  }

  @override
  void dispose() {
    blocStream.cancel();
    filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Hero(tag: 'logo', child: Image.asset(AppAssets.marvelLogo)),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final filters = await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const FilterModalWidget();
                  }) as FilterCharacterListDTO?;

              if (context.mounted && filters != null) {
                filter.value = filters;
                context
                    .read<CharacterBloc>()
                    .add(FetchCharacterListEvent(filters));
              }
            },
            icon: const Icon(Icons.filter_alt_outlined),
            color: Colors.white,
          )
        ],
        backgroundColor: AppColors.blueIndigo,
      ),
      backgroundColor: AppColors.blueIndigo,
      body: SafeArea(
        child: BlocBuilder<CharacterBloc, HomeState>(
          bloc: context.read<CharacterBloc>(),
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.red,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Please Wait...',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              );
            }

            if (state is HomeCharacterListNoResultsState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.spiderManSad,
                      height: 300,
                    ),
                    const Text(
                      'No results found.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              );
            }

            if (state is HomeSuccessfulFetchedState) {
              return GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                padding: const EdgeInsets.all(16.0),
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final listOfCharaters = state.characters;
                  final character = listOfCharaters[index];

                  return GridCharacterCardWidget(
                    character: character,
                    relationatedCharacters: listOfCharaters,
                  );
                },
              );
            }
            if (state is HomeGridLoadingState) {
              return GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                padding: const EdgeInsets.all(16.0),
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final listOfCharaters = state.characters;
                  final character = listOfCharaters[index];

                  return GridCharacterCardWidget(
                    character: character,
                    relationatedCharacters: listOfCharaters,
                  );
                },
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MarvelButtonWidget(
                    onTap: () {
                      context.read<CharacterBloc>().add(
                            FetchCharacterListEvent(
                              FilterCharacterListDTO(
                                offset: 0,
                              ),
                            ),
                          );
                    },
                    text: 'Try to fetch data.',
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
