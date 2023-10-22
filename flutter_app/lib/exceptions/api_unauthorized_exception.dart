import 'package:flutter_app/exceptions/api_exception.dart';

class APIUnauthorizedException extends APIException {
  APIUnauthorizedException() : super('Unauthorized');

  @override
  String get className => (APIUnauthorizedException).toString();
}
