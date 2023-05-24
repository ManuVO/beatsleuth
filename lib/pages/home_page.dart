// home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {


  const HomePage({Key? key}) : super(key: key);

  String _getSaludo() {
    final hora = DateTime.now().hour;
    if (hora < 12) {
      return '¡Buenos días!';
    } else if (hora < 18) {
      return '¡Buenas tardes!';
    } else {
      return '¡Buenas noches!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_getSaludo(), style: Theme.of(context).textTheme.displayLarge),
    );
  }
}