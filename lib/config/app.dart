import 'package:booklog/config/routes.dart';
import 'package:booklog/screens/booklist/presentation/widget_booklist.dart';
import 'package:booklog/screens/home/presentation/widget_home.dart';
import 'package:booklog/screens/auth/register/presentation/widget_register_user.dart';
import 'package:booklog/screens/auth/login/presentation/widget_login_user.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booklog',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      initialRoute: Routes.login,
      routes: {
        Routes.home :(context) => WidgetHome(),
        Routes.booklist :(context) => const WidgetBooklist(),
        Routes.registerUser :(context) => const WidgetRegisterUser(),
        Routes.login :(context) => const WidgetLoginUser(),
      },
    );
  }
}