import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/services/google_signin/google_signin_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInServiceImpl implements GoogleSignInService {
  @override
  Future<Result<String>> isSignedIn() async {
    try {
      final logged = await GoogleSignIn.instance.attemptLightweightAuthentication();
      if(logged case GoogleSignInAuthentication(:final idToken?)){
        return Success(idToken);
      }
      return Failure(Exception('User not logged in Google'));
    } catch (e, s) {
      log(
        'User is not logged in from Google',
        name: 'GoogleSignInService',
        error: e,
        stackTrace: s,
      );
      return Failure(
        Exception('User is not logged in from Google'),
      );
    }
  }

  @override
  Future<Result<String>> signIn() async {
    try {
      final auth = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile', 'openid'],
      );

      if (auth.authentication case GoogleSignInAuthentication(
        idToken: final idToken?,
      )) {
        return Success(idToken);
      }
      return Failure(
        Exception('Failed to retrieve ID token from Google Sign-In'),
      );
    } catch (e, s) {
      log(
        'Failed to retrieve ID token from Google Sign-In',
        name: 'GoogleSignInService',
        error: e,
        stackTrace: s,
      );
      return Failure(
        Exception('Failed to retrieve ID token from Google Sign-In'),
      );
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      return successOfUnit();
    } catch (e, s) {
      log(
        'Failed to logout from Google',
        name: 'GoogleSignInService',
        error: e,
        stackTrace: s,
      );
      return Failure(
        Exception('Failed to logout from Google'),
      );
    }
  }
}
