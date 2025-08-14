import 'package:cine_box/config/env.dart';
import 'package:cine_box/ui/core/themes/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineBox Splash Screen Riverpod'),
      ),
      body: Center(
        child: Image.asset(R.ASSETS_IMAGES_BG_LOGIN_PNG),
      ),
    );
  }
}
