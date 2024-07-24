import 'package:mottu_marvel/shared/exceptions/app_exceptions.dart';

class CharacterException implements AppException {
  final String message;
  const CharacterException(this.message);
}
