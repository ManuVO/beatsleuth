import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'package:beatsleuth/utils/theme_util.dart';

class WrapperPage extends StatefulWidget {
  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
  ];
  final List<int> _navigationHistory = [];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _navigationHistory.add(index);
    });
  }

  Future<bool> _onWillPop() async {
    if (_navigationHistory.isNotEmpty) {
      setState(() {
        _selectedIndex = _navigationHistory.removeLast();
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: navBarColor(),
          showUnselectedLabels: true,
          selectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
