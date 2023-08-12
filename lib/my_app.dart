import 'package:flutter/material.dart';
// import 'package:rexello_tests_only_home/screens/success_page/success.dart';

import 'screens/detail_screen/detail_screen.dart';
import 'screens/product_finder/product_finder.dart';
import 'screens/series_screen/series_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/success_page/success.dart';
import 'screens/view_by_screen/view_by_screen.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
// MyApp starting UI -> draws first screen which is splash screen
//
//
//
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //
  // delete user data when app closed to keep size small
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    clearCache();
    clearUserData();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is being put in the background
      clearCache();
      clearUserData();
    }
  }

  Future<void> clearCache() async {
    final cache = DefaultCacheManager();
    await cache.emptyCache();
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  // end
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const SplashScreen(),
        '/home': (context) => const ViewByScreen(
              initialTabIndex: 0,
            ),
        '/finder': (context) => const ProductFinderScreen(),
        '/series': (context) => const SeriesScreen(
              getUrl: '',
              type: '',
            ),
        '/details': (context) => const DetailScreen(
              description: '',
              heroId: 1,
              image: '',
              title: '',
              weight: '',
            ),
        '/success': (context) => SuccessPage(),
      },
    );
  }
}
