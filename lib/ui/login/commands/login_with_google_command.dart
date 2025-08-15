
import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/repositories/repositories_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_with_google_command.g.dart';

@Riverpod()
class LoginWithGoogleCommand extends _$LoginWithGoogleCommand {

  @override
  AsyncValue<void> build() => AsyncData(null);

  Future<void> execute() async {
    state = AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    var result = await authRepository.signIn();
    
    switch(result){
      case Success<Unit>():
        state = AsyncData(null);
      case Failure<Unit>():
        state = AsyncError('Error in do Login with Google', StackTrace.current);
    }
  }

}