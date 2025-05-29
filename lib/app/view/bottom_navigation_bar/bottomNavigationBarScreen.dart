import 'package:flutter/material.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/view/SplashScreen.dart';
import 'package:notes_taking_app_dio/app/view/addNotesScreen/addNewNotesScreen.dart';
import 'package:notes_taking_app_dio/app/view/auth/RegisterScreen.dart';
import 'package:notes_taking_app_dio/app/view/auth/loginScreen.dart';
import 'package:notes_taking_app_dio/app/view/notesScreen/notesViewScreen.dart';
import 'package:notes_taking_app_dio/app/view/profileScreen/myProfileScreen.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Bottomnavigationbarscreen extends StatefulWidget {
  const Bottomnavigationbarscreen({super.key});

  @override
  State<Bottomnavigationbarscreen> createState() =>
      _BottomnavigationbarscreenState();
}

class _BottomnavigationbarscreenState extends State<Bottomnavigationbarscreen> {
  PersistentTabController _controller = PersistentTabController(
      historyLength: 1, initialIndex: 1, clearHistoryOnInitialIndex: true);
  @override
  Widget build(BuildContext context) {
    print(_controller.index);
    return Scaffold(
      body: PersistentTabView(
        // popAllScreensOnTapOfSelectedTab: true,

        controller: _controller,
        screenTransitionAnimation:
            ScreenTransitionAnimation(curve: Curves.easeInCirc),
        backgroundColor: Colors.white,
        tabs: [
          PersistentTabConfig(
            screen: NotesViewScreen(),
            item: ItemConfig(
                activeForegroundColor: AppColors.iconColor,
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                inactiveIcon: Icon(
                  Icons.home,
                  size: 24,
                )),
          ),
          PersistentTabConfig(
            screen: AddNewNotesScreen(),
            item: ItemConfig(
              activeForegroundColor: AppColors.iconColor,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          PersistentTabConfig(
            screen: Myprofilescreen(),
            item: ItemConfig(
              activeForegroundColor: AppColors.iconColor,
              icon: Icon(
                Icons.person_3_rounded,
                size: 30,
              ),
              inactiveIcon: Icon(
                Icons.person_3_rounded,
                size: 26,
              ),
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style13BottomNavBar(
          navBarDecoration:
              NavBarDecoration(borderRadius: BorderRadius.circular(20)),
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
