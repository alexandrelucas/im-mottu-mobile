import 'package:flutter/material.dart';

import 'package:mottu_marvel/constants/app_colors.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const route = '/character';

  final CharacterMarvelEntity character;
  final List<CharacterMarvelEntity> relationatedCharacters;
  const CharacterDetailScreen({
    super.key,
    required this.character,
    required this.relationatedCharacters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.blueIndigo,
        automaticallyImplyLeading: true,
        title: Text(
          character.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      backgroundColor: AppColors.blueIndigo,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              character.thumbnail,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 24),
            // if (character.description.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                character.description.isEmpty
                    ? 'No description found.'
                    : character.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Relationated Characters:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relationatedCharacters.length,
                itemBuilder: (context, index) {
                  final character = relationatedCharacters[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    width: 100,
                    height: 100,
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.black,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: InkWell(
                        // onTap: () => Modular.to.pushNamed(
                        //   "character",
                        //   arguments: {
                        //     'character': character,
                        //     'list': relationatedCharacters,
                        //   },
                        // ),
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
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
