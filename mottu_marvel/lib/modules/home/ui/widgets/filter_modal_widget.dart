import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/constants/app_colors.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';
import 'package:mottu_marvel/modules/home/ui/widgets/marvel_button_widget.dart';

class FilterModalWidget extends StatefulWidget {
  const FilterModalWidget({super.key});

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  final nameController = TextEditingController();
  String? orderBy = 'name';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: nameController,
            decoration:
                const InputDecoration(filled: true, hintText: 'Name to filter'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Filter by: ',
            textAlign: TextAlign.start,
          ),
          Row(
            children: [
              Radio(
                activeColor: AppColors.red,
                groupValue: orderBy,
                value: 'name',
                onChanged: (value) {
                  setState(() {
                    orderBy = value;
                  });
                },
              ),
              GestureDetector(
                  onTap: () => setState(() => orderBy = 'name'),
                  child: const Text('Name')),
              Radio(
                activeColor: AppColors.blueIndigo,
                groupValue: orderBy,
                value: 'modified',
                onChanged: (value) {
                  setState(() {
                    orderBy = value;
                  });
                },
              ),
              GestureDetector(
                  onTap: () => setState(() => orderBy = 'modified'),
                  child: const Text('Modified'))
            ],
          ),
          const SizedBox(height: 16),
          MarvelButtonWidget(
              onTap: () {
                final name = nameController.text;
                Modular.to.pop(
                  FilterCharacterListDTO(
                    nameStartsWith: name.isNotEmpty ? name : null,
                    orderBy: FilterCharacterOrderBy.values
                        .firstWhere((filter) => filter.value == orderBy),
                  ),
                );
              },
              text: 'Apply Filter')
        ],
      ),
    );
  }
}
