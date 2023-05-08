import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beatsleuth/pages/wrapper_page.dart';

void main() {

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeatSluth',
        home: WrapperPage(),
      ),
    );
  }
}
