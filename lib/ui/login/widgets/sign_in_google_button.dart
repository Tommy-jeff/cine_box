import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/core/themes/resources.dart';
import 'package:flutter/material.dart';

class SignInGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SignInGoogleButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: !isLoading,
              replacement: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              child: Image.asset(R.ASSETS_IMAGES_GOOGLE_LOGO_PNG),
            ),
          ),
          Text(
            !isLoading ? 'Login with Google' : 'Realizando Login...',
            style: TextStyle(fontSize: 14, color: AppColors.dartGrey),
          ),
        ],
      ),
    );
  }
}
