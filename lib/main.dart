import 'package:carino/pages/welcom_page.dart';
import 'package:carino/providers/finance_provider.dart';
import 'package:carino/providers/navigation_provider.dart';
import 'package:carino/providers/task_provider.dart';
import 'package:carino/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => FinanceProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Theme Switcher',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true),
            themeMode: themeProvider.themeMode,
            darkTheme: ThemeData.dark(useMaterial3: true),
            home: const WelcomePage(),
          );
        },
      ),
    );
  }
}
