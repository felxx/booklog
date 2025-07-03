import 'package:booklog/config/routes.dart';
import 'package:booklog/screens/home/presentation/widget_home.dart';
import 'package:booklog/screens/auth/register/presentation/widget_register_user.dart';
import 'package:booklog/screens/auth/login/presentation/widget_login_user.dart';
import 'package:booklog/screens/my_collection/presentation/widget_booklist.dart';
import 'package:booklog/screens/search/presentation/widget_search.dart';
import 'package:booklog/screens/settings/presentation/widget_settings.dart';
import 'package:booklog/screens/statistics/presentation/widget_statistics.dart';
import 'package:booklog/screens/wishlist/presentation/widget_wishlist.dart';
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
        colorScheme: const ColorScheme.dark(primary: Colors.amber),
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const WidgetHome(),
        Routes.registerUser: (context) => const WidgetRegisterUser(),
        Routes.login: (context) => const WidgetLoginUser(),
        Routes.statistics: (context) => const WidgetStatistics(),
        Routes.wishlist: (context) => const WidgetWishlist(),
        Routes.search: (context) => const WidgetSearch(),
        Routes.settings: (context) => const WidgetSettings(),
        Routes.booklist: (context) => const WidgetBooklist(),
      },
    );
  }
}