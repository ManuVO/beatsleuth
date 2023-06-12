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
    HomePage(data: HomePageData()),
    SearchPage(data: SearchPageData()),
  ];
  final List<int> _navigationHistory = [0];

  void _onItemTap(int index) {
    setState(() {
      if (index == _selectedIndex) {
        if (index == 0) {
          final oldPage = _pages[index] as HomePage;
          _pages[index] = HomePage(key: UniqueKey(), data: oldPage.data);
        } else if (index == 1) {
          final oldPage = _pages[index] as SearchPage;
          _pages[index] = SearchPage(key: UniqueKey(), data: oldPage.data);
        }
      }
      _selectedIndex = index;
      _navigationHistory.add(index);
    });
  }

  Future<bool> _onWillPop() async {
    if (_navigationHistory.length > 1) {
      setState(() {
        _navigationHistory.removeLast();
        _selectedIndex = _navigationHistory.last;
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
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _pages[_selectedIndex],
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
          selectedItemColor: Theme.of(context).focusColor,
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
