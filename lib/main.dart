// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/wrapper_page.dart';
import 'pages/default_page.dart';
import 'utils/theme_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  */
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1ED760),
        focusColor: Color.fromARGB(255, 255, 187, 75),
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 20, 34),
        textTheme: circularStdTextTheme(),
      ),
      home: SafeArea(child: WrapperPage()),
    );
  }
}
