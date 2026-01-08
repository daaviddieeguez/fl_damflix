import 'package:fl_damflix/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fl_damflix/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DAMFLIX',
      initialRoute: 'home',
      routes: {
        'home':(context) => HomeScreen(),
        'details':(context) => DetailsScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}