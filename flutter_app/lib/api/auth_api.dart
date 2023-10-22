import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/gql_client.dart';
import 'package:flutter_app/commands/register_cmd.dart';
import 'package:flutter_app/commands/sign_in_cmd.dart';
import 'package:flutter_app/models/user.dart';
import 'package:graphql/client.dart';

class AuthAPI extends API {
  final GQLClient _gql = GQLClient();

  Future<User> signIn(SignInCmd cmd) async {
    final result = await _gql.anon().mutate(
          MutationOptions(
            document: gql("""
              mutation {
                login(loginUserInput: {
                  username: "${cmd.username}",
                  password: "${cmd.password}"
                }) {
                  id
                  username
                  name
                  accessToken
                }
              }
            """),
          ),
        );
    handle(result);
    return User.fromJson(result.data!['login']);
  }

  Future<void> register(RegisterCmd cmd) async {
    final result = await _gql.anon().mutate(
          MutationOptions(
            document: gql("""
              mutation {
                registerUser(registerUserInput: {
                  name: "${cmd.name}",
                  username: "${cmd.username}",
                  password: "${cmd.password}"
                }) {
                  id
                  username
                  name
                }
              }
            """),
          ),
        );

    handle(result);
  }
}
