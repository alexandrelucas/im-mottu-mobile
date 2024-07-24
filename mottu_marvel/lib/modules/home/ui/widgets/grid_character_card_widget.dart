import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/constants/app_colors.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';

class GridCharacterCardWidget extends StatelessWidget {
  final CharacterMarvelEntity character;
  final List<CharacterMarvelEntity> relationatedCharacters;

  const GridCharacterCardWidget({
    super.key,
    required this.character,
    required this.relationatedCharacters,
  });

  @override
  Widget build(BuildContext context) {
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
          arguments: {
            'character': character,
            'list': relationatedCharacters,
          },
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
  }
}
