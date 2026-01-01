// ignore_for_file: must_be_immutable

import 'package:carino/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class botomPage extends StatelessWidget {
  botomPage({super.key, this.onTap});
  void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) {
        return BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          currentIndex: navigationProvider.currentIndex,
          onTap: onTap,
          selectedFontSize: 20,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_add),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_sharp),
              label: 'Fainace',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mode_night_outlined),
              label: 'Theme',
            ),
          ],
        );
      },
    );
  }
}
