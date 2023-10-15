import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() => runApp(const MyApp());

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.pink);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: kColorScheme),
      home: const TabsScreen(),
    );
  }
}
