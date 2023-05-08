import 'package:beatsleuth/data/providers/search_provider.dart';
import 'package:beatsleuth/pages/home_page.dart';
import 'package:beatsleuth/pages/search_page.dart';
import 'package:beatsleuth/utils/color_util.dart';
import 'package:beatsleuth/data/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WrapperPage extends StatelessWidget {
  final PageController pageController = PageController();

  WrapperPage({Key? key}) : super(key: key);
  Future changePage(context, int index) async {
    Provider.of<AppProvider>(context, listen: false).changePage(index);
    await pageController.animateToPage(index, duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  Widget navbarWidget(context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 65.5,
      padding: EdgeInsets.only(left: size.width * 0.13, right: size.width * 0.13),
      decoration: BoxDecoration(color: ColorPalette.navbarColor),
      child: BottomNavigationBar(
        onTap: (index) async => await changePage(context, index),
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          //Botón de home
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.home_rounded,
                  size: 26,
                  color: ColorPalette.navbarIconColor
                ),
                Consumer<AppProvider>(builder: (context, appProvider, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: appProvider.page == 0
                      ? Container(
                        key: UniqueKey(),
                        margin: const EdgeInsets.only(top: 6),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(color: ColorPalette.navbarIconColor, borderRadius: BorderRadius.circular(5)),
                        width: 22,
                        height: 3.2,
                      )
                    : SizedBox(key: UniqueKey(),)
                  );
                })
              ],
            ),
            label: 'Home',
          ),
          //Botón de búsqueda
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 26,
                  color: ColorPalette.navbarIconColor
                ),
                Consumer<AppProvider>(builder: (context, appProvider, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: appProvider.page == 1
                      ? Container(
                        key: UniqueKey(),
                        margin: const EdgeInsets.only(top: 6),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(color: ColorPalette.navbarIconColor, borderRadius: BorderRadius.circular(5)),
                        width: 22,
                        height: 3.2,
                      )
                    : SizedBox(key: UniqueKey(),)
                  );
                })
              ],
            ),
            label: 'Search',
            ),
            //Botón de búsqueda avanzada
            BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.content_paste_search_rounded,
                  size: 26,
                  color: ColorPalette.navbarIconColor
                ),
                Consumer<AppProvider>(builder: (context, appProvider, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: appProvider.page == 2
                      ? Container(
                        key: UniqueKey(),
                        margin: const EdgeInsets.only(top: 6),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(color: ColorPalette.navbarIconColor, borderRadius: BorderRadius.circular(5)),
                        width: 22,
                        height: 3.2,
                      )
                    : SizedBox(key: UniqueKey(),)
                  );
                })
              ],
            ),
            label: 'Advanced Search',
            ),
            //Botón de librería
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.library_music_rounded,
                  size: 26,
                  color: ColorPalette.navbarIconColor
                ),
                Consumer<AppProvider>(builder: (context, appProvider, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: appProvider.page == 3
                      ? Container(
                        key: UniqueKey(),
                        margin: const EdgeInsets.only(top: 6),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(color: ColorPalette.navbarIconColor, borderRadius: BorderRadius.circular(5)),
                        width: 22,
                        height: 3.2,
                      )
                    : SizedBox(key: UniqueKey(),)
                  );
                })
              ],
            ),
            label: 'Library',
            ),
            //Botón de perfil
            BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 26,
                  color: ColorPalette.navbarIconColor
                ),
                Consumer<AppProvider>(builder: (context, appProvider, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: appProvider.page == 4
                      ? Container(
                        key: UniqueKey(),
                        margin: const EdgeInsets.only(top: 6),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(color: ColorPalette.navbarIconColor, borderRadius: BorderRadius.circular(5)),
                        width: 22,
                        height: 3.2,
                      )
                    : SizedBox(key: UniqueKey(),)
                  );
                })
              ],
            ),
            label: 'Profile',
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
      ],
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: navbarWidget(context),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              HomePage((index) => changePage(context, index)),
              SearchPage((index) => changePage(context, index))
            ],
          ),
        );
      },
    );

    return Container();
  }
}