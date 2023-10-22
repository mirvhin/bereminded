import 'package:flutter_app/models/user.dart';
import 'package:localstorage/localstorage.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();

  factory StorageService() {
    return instance;
  }

  StorageService._internal();

  Future<String> getAccessToken() async {
    await LocalStorage('bereminded').ready;
    return LocalStorage('bereminded').getItem("jwt");
  }

  Future<User?> getUser() async {
    await LocalStorage('bereminded').ready;
    String str = LocalStorage('bereminded').getItem("user") ?? "";

    if (str != "") return userFromJson(str);
    return null;
  }

  void setUser(User user) {
    LocalStorage('bereminded').setItem("jwt", user.accessToken);
    LocalStorage('bereminded').setItem("user", userToJson(user));
  }

  void clear() {
    LocalStorage('bereminded').clear();
  }
}
