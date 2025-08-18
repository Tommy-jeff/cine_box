import 'package:cine_box/data/core/rest_client/backend_rest_client_provider.dart';
import 'package:cine_box/data/core/rest_client/tmdb_rest_client_provider.dart';
import 'package:cine_box/data/services/auth/auth_service.dart';
import 'package:cine_box/data/services/google_signin/google_signin_service.dart';
import 'package:cine_box/data/services/google_signin/google_signin_service_impl.dart';
import 'package:cine_box/data/services/local_storage/local_storage_service.dart';
import 'package:cine_box/data/services/local_storage/local_storage_service_impl.dart';
import 'package:cine_box/data/services/movies/movies_service.dart';
import 'package:cine_box/data/services/tmdb/tmdb_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_providers.g.dart';

@riverpod
GoogleSignInService googleSignInService(Ref ref) {
  return GoogleSignInServiceImpl();
}

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  return LocalStorageServiceImpl(flutterSecureStorage: FlutterSecureStorage());
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(ref.read(backendRestClientProvider));
}

@riverpod
TmdbService tmdbService(Ref ref){
  return TmdbService(ref.read(tmdbRestClientProvider));
}

@riverpod
MovieService movieService(Ref ref){
  return MovieService(ref.read(backendRestClientProvider));
}
