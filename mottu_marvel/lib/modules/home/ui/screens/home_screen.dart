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

  @override
  void initState() {
    super.initState();

    context.read<CharacterBloc>().add(
          FetchCharacterListEvent(
            FilterCharacterListDTO(
              limit: 20,
            ),
          ),
        );

    // Watch Error State
    blocStream = context.read<CharacterBloc>().stream.listen((state) {
      if (state is HomeErrorState) {
        context.showSnackMessage(state.message);
      }
    });
  }

  @override
  void dispose() {
    blocStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Image.asset(AppAssets.marvelLogo),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                padding: const EdgeInsets.all(16.0), // padding around the grid
                itemCount: state.characters.length, // total number of items
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
                                  limit: 20,
                                ),
                              ),
                            );
                      },
                      text: 'Try to fetch data.')
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
