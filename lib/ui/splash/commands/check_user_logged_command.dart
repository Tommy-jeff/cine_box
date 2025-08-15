import 'package:cine_box/data/repositories/repositories_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cine_box/core/result/result.dart';

part 'check_user_logged_command.g.dart';

@Riverpod()
class CheckUserLoggedCommand extends _$CheckUserLoggedCommand {
  @override
  Future<bool?> build() async => null;

  Future<void> execute() async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.isLogged();
    state = switch(result){
      Success(value: final isLogged) => AsyncData(isLogged),
      Failure(: final error) => AsyncError(error, StackTrace.current)
    };
  }
}
