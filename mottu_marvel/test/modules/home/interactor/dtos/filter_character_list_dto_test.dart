import 'package:flutter_test/flutter_test.dart';
import 'package:mottu_marvel/modules/home/interactor/dtos/filter_character_list_dto.dart';

void main() {
  test('filter character list dto ...', () async {
    FilterCharacterListDTO filter =
        FilterCharacterListDTO(offset: 0, nameStartsWith: "Jose");

    print(filter.toString());
  });
}
