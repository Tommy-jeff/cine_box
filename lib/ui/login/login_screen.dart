import 'package:cine_box/ui/core/themes/resources.dart';
import 'package:cine_box/ui/core/widgets/loader_messages.dart';
import 'package:cine_box/ui/login/commands/login_with_google_command.dart';
import 'package:cine_box/ui/login/login_view_model.dart';
import 'package:cine_box/ui/login/widgets/sign_in_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with LoaderAndMessages {
  @override
  Widget build(BuildContext context) {
    
    ref.listen(loginWithGoogleCommandProvider, (_, state){
      state.whenOrNull(
        data: (_){
          Navigator.pushReplacementNamed(context, '/home');
        },
        error: (error, stacktrace){
          showErrorSnackBar('Error in do Login with Google');
        }
      );
    });
    
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            R.ASSETS_IMAGES_BG_LOGIN_PNG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black.withAlpha(170),
          ),
          Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.only(top: 108),
            child: Column(
              children: [
                Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 48,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(loginWithGoogleCommandProvider);

                      return SignInGoogleButton(
                        onPressed: () {
                          final loginViewModel = ref.read(
                            loginViewModelProvider,
                          );
                          loginViewModel.loginWithGoogle();
                        },
                        isLoading: state.isLoading,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
