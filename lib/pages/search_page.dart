// search_page.dart
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {

  
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Buscar', style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
