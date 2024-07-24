import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/constants/app_colors.dart';
import 'package:mottu_marvel/modules/home/interactor/blocs/character_bloc.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/interactor/events/fetch_character_list_event.dart';
import 'package:mottu_marvel/modules/home/interactor/states/home_state.dart';
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
          child: Image.asset('assets/marvel.png'),
        ),
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

                  return Material(
                    clipBehavior: Clip.antiAlias,
                    color: Colors.black,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => Modular.to.pushNamed(
                        "character",
                        arguments: character,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ShaderMask(
                            blendMode: BlendMode.srcATop,
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.1,
                                  1.0,
                                ],
                                colors: [
                                  Colors.transparent,
                                  AppColors.blueIndigo,
                                ],
                              ).createShader(bounds);
                            },
                            child: Container(
                              color: AppColors.red.withOpacity(0.5),
                              child: Image.network(
                                fit: BoxFit.cover,
                                character.thumbnail,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Text(character.name);
                                },
                              ),
                            ),
                          ),
                          Align(
                              alignment: const Alignment(0, 0.8),
                              child: Text(
                                character.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    clipBehavior: Clip.antiAlias,
                    color: Colors.black,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<CharacterBloc>().add(
                              FetchCharacterListEvent(
                                FilterCharacterListDTO(
                                  limit: 20,
                                ),
                              ),
                            );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 180,
                        color: AppColors.red,
                        child: const Text("Try to fetch data",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
