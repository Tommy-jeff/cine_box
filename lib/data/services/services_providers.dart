import 'package:cine_box/data/services/google_signin/google_signin_service.dart';
import 'package:cine_box/data/services/google_signin/google_signin_service_impl.dart';
import 'package:cine_box/data/services/local_storage/local_storage_service.dart';
import 'package:cine_box/data/services/local_storage/local_storage_service_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_providers.g.dart';

@Riverpod()
GoogleSignInService googleSignInService(Ref ref) {
  return GoogleSignInServiceImpl();
}

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  return LocalStorageServiceImpl(flutterSecureStorage: FlutterSecureStorage());
}
