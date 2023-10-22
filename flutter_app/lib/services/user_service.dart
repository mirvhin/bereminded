import 'package:flutter_app/api/auth_api.dart';
import 'package:flutter_app/commands/register_cmd.dart';
import 'package:flutter_app/commands/sign_in_cmd.dart';
import 'package:flutter_app/models/user.dart';

class UserService {
  static final UserService instance = UserService._internal();

  factory UserService() {
    return instance;
  }

  UserService._internal();

  final AuthAPI _api = AuthAPI();

  Future<User> signIn(SignInCmd cmd) async {
    return _api.signIn(cmd);
  }

  Future<void> register(RegisterCmd cmd) async {
    return _api.register(cmd);
  }
}
