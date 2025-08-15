import 'package:cine_box/cinebox_main_app.dart';
import 'package:cine_box/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  GoogleSignIn.instance.initialize(
    serverClientId: Env.googleApiKey
  );

  runApp(ProviderScope(child: CineBoxMainApp()));
}
