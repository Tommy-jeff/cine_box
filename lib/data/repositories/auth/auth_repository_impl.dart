import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/exceptions/data_exception.dart';
import 'package:cine_box/data/repositories/auth/auth_repository.dart';
import 'package:cine_box/data/services/auth/auth_service.dart';
import 'package:cine_box/data/services/google_signin/google_signin_service.dart';
import 'package:cine_box/data/services/local_storage/local_storage_service.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalStorageService _localStorageService;
  final GoogleSignInService _googleSigninService;
  final AuthService _authService;

  AuthRepositoryImpl({
    required LocalStorageService localStorageService,
    required GoogleSignInService googleSigninService,
    required AuthService authService,
  }) : _localStorageService = localStorageService,
       _googleSigninService = googleSigninService,
       _authService = authService;

  @override
  Future<Result<bool>> isLogged() async {
    final resultToken = await _localStorageService.getIdToken();

    return switch (resultToken) {
      Success<String>() => Success(true),
      Failure<String>() => Success(false),
    };
  }

  @override
  Future<Result<Unit>> signIn() async {
    final result = await _googleSigninService.signIn();
    switch (result) {
      case Success<String>(:final value):
        try {
          await _localStorageService.saveIdToken(value);
          await _authService.auth();
          return successOfUnit();
        } on DioException catch (e, s) {
          log(
            'Error in authenticate user in api',
            name: 'AuthRepository',
            error: e,
            stackTrace: s,
          );
          return Failure(
            DataException(message: 'Error in authenticate user in api'),
          );
        }
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
