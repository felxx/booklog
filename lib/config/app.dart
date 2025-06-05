import 'package:booklog/config/routes.dart';
import 'package:booklog/screens/booklist/presentation/widget_booklist.dart';
import 'package:booklog/screens/home/presentation/widget_home.dart';
import 'package:booklog/screens/auth/register/presentation/widget_register_user.dart';
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
        primarySwatch: Colors.orange,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home :(context) => WidgetHome(),
        Routes.booklist :(context) => const WidgetBooklist(),
        Routes.registerUser :(context) => const WidgetRegisterUser()
      },
    );
  }
}
