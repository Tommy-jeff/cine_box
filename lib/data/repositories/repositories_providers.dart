

import 'package:cine_box/data/repositories/auth/auth_repository.dart';
import 'package:cine_box/data/repositories/auth/auth_repository_impl.dart';
import 'package:cine_box/data/repositories/movies/movies_repository.dart';
import 'package:cine_box/data/repositories/movies/movies_repository_impl.dart';
import 'package:cine_box/data/repositories/tmdb/tmbd_repository_impl.dart';
import 'package:cine_box/data/repositories/tmdb/tmdb_repository.dart';
import 'package:cine_box/data/services/services_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref){
  return AuthRepositoryImpl(
      localStorageService: ref.read(localStorageServiceProvider),
      googleSigninService: ref.read(googleSignInServiceProvider),
      authService:  ref.read(authServiceProvider)
  );
}

@riverpod
TmdbRepository tmdbRepository(Ref ref){
  return TmdbRepositoryImpl(tmdbService: ref.read(tmdbServiceProvider));
}

@riverpod
MoviesRepository moviesRepository(Ref ref){
  return MoviesRepositoryImpl(movieService: ref.read(movieServiceProvider));
}
