import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "my_app.dart";

void main() {
  // Set preferred orientations to portrait only
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
  runApp(const MyApp());
}
