import 'package:cine_box/ui/core/themes/theme.dart';
import 'package:cine_box/ui/home/home_screen.dart';
import 'package:cine_box/ui/login/login_screen.dart';
import 'package:cine_box/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class CineBoxMainApp extends StatelessWidget {
  const CineBoxMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineBox',
      theme: AppTheme.theme,
      routes:{
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/home': (_) => HomeScreen(),
      }
    );
  }
}
