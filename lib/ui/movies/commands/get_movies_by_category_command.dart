import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/domain/models/movies_by_category.dart';
import 'package:cine_box/domain/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movies_by_category_command.g.dart';

@riverpod
class GetMoviesByCategoryCommand extends _$GetMoviesByCategoryCommand {
  @override
  AsyncValue<MoviesByCategory?> build() {
    return const AsyncData(null);
  }

  Future<void> execute() async {
    state = AsyncLoading();
    final getMoviesByCategoryUsecase = ref.read(
      getMoviesByCategoryUsecaseProvider,
    );
    final result = await getMoviesByCategoryUsecase.execute();

    state = switch (result) {
      Success(value: final moviesByCategory) => AsyncData(moviesByCategory),
      Failure() => AsyncError(
        'Error in get movies by category',
        StackTrace.current,
      ),
    };
  }
}
