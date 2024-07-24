import 'package:flutter/material.dart';

import 'package:mottu_marvel/constants/app_colors.dart';
import 'package:mottu_marvel/modules/home/interactor/entities/character_entity.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const route = '/character';

  final CharacterMarvelEntity character;
  const CharacterDetailScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.blueIndigo,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.blueIndigo,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(character.thumbnail),
            const SizedBox(height: 24),
            Text(
              character.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            if (character.description.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  character.description,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }
}
