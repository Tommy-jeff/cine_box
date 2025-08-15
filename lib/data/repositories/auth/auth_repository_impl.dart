import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/exceptions/data_exception.dart';
import 'package:cine_box/data/repositories/auth/auth_repository.dart';
import 'package:cine_box/data/services/local_storage/local_storage_service.dart';
import 'package:cine_box/data/services/google_signin/google_signin_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalStorageService _localStorageService;
  final GoogleSignInService _googleSigninService;

  AuthRepositoryImpl({
    required LocalStorageService localStorageService,
    required GoogleSignInService googleSigninService,
  }) : _localStorageService = localStorageService,
       _googleSigninService = googleSigninService;

  @override
  Future<Result<bool>> isLogged() async {
    final resultToken = await _localStorageService.getIdToken();

    return switch(resultToken){
      Success<String>() => Success(true),
      Failure<String>() => Success(false),

    // final result = await _googleSigninService.isSignedIn();
    // switch (result) {
    //   case Success<String>(:final value):
    //     await _localStorageService.saveIdToken(value);
    //     // TODO login in our backend
    //     return Success<bool>(true);
    //   case Failure<Unit>(:final error):
    //     log(
    //       'User is not logged in Google',
    //       name: 'AuthRepository',
    //       error: error,
    //     );
    //     return Failure(DataException(message: 'User is not logged in Google'));
    };
  }

  @override
  Future<Result<Unit>> signIn() async {
    final result = await _googleSigninService.signIn();
    switch (result) {
      case Success<String>(:final value):
        await _localStorageService.saveIdToken(value);
        // TODO login in our backend
        return successOfUnit();
      case Failure<String>(:final error):
        log(
          'Error in sign in with Google',
          name: 'AuthRepository',
          error: error,
        );
        return Failure(DataException(message: 'Error in sign in with Google'));
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    final result = await _googleSigninService.signOut();
    switch (result) {
      case Success<Unit>():
        final removeResult = await _localStorageService.removeIdToken();
        switch (removeResult) {
          case Success<Unit>():
            return successOfUnit();
          case Failure<Unit>(:final error):
            log(
              'Error remove id token from local storage',
              name: 'AuthRepository',
              error: error,
            );
            return Failure(
              DataException(message: 'Error in sign out with Google'),
            );
        }
      case Failure<Unit>(:final error):
        log(
          'Error in sign out with Google',
          name: 'AuthRepository',
          error: error,
        );
        return Failure(DataException(message: 'Error in sign out with Google'));
    }
  }
}
