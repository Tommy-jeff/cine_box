import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/domain/models/movie.dart';
import 'package:cine_box/domain/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movies_by_genre_command.g.dart';

@riverpod
class GetMoviesByGenreCommand extends _$GetMoviesByGenreCommand {
  @override
  AsyncValue<List<Movie>> build() => AsyncLoading();

  Future<void> execute(int genreId) async {
    state = AsyncLoading();
    final genreUsecase = ref.read(getMoviesByGenreUsecaseProvider);
    final result = await genreUsecase.execute(genreId: genreId);

    state = switch (result) {
      Success(:final value) => AsyncData(value),
      Failure() => AsyncError(
        Exception('Error in get movies by genre'),
        StackTrace.current,
      ),
    };
  }
}
