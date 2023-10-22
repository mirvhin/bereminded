import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth/sign_in/sign_in.dart';
import 'package:flutter_app/pages/router.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  final AppRouter _route = AppRouter();

  @override
  State<App> createState() => _AppState(_route);
}

class _AppState extends State<App> {
  final AppRouter _router;

  _AppState(this._router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be Reminded System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routes: _router.routes,
      initialRoute: SignInPage.routeName,
    );
  }
}
