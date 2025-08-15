

import 'package:cine_box/data/repositories/auth/auth_repository.dart';
import 'package:cine_box/data/repositories/auth/auth_repository_impl.dart';
import 'package:cine_box/data/services/services_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories_providers.g.dart';

@Riverpod()
AuthRepository authRepository(Ref ref){
  return AuthRepositoryImpl(
      localStorageService: ref.read(localStorageServiceProvider),
      googleSigninService: ref.read(googleSignInServiceProvider),
      authService:  ref.read(authServiceProvider)
  );
}