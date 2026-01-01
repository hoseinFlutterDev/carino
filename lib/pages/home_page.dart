// ignore_for_file: camel_case_types

import 'package:carino/pages/botom_page/botomnav.dart';
import 'package:carino/pages/botom_page/fab_page.dart';
import 'package:carino/pages/botom_page/finance.dart';
import 'package:carino/pages/botom_page/task.dart';
import 'package:carino/pages/botom_page/theme.dart';
import 'package:carino/providers/navigation_provider.dart';
import 'package:carino/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  List<Widget> get pages => [
    TaskPage(scaleAnimation: _scaleAnimation),
    financePage(scaleAnimation: _scaleAnimation),
    const ThemePage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return SafeArea(
              child: Scaffold(
                floatingActionButton: buildFAB(
                  context,
                  navigationProvider.currentIndex,
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: IndexedStack(
                  index: navigationProvider.currentIndex,
                  children: pages,
                ),
                bottomNavigationBar: botomPage(
                  onTap: (value) {
                    navigationProvider.setIndex(value);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
