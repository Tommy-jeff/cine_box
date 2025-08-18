
import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/domain/models/movie.dart';
import 'package:cine_box/domain/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movies_by_search_command.g.dart';

@riverpod
class GetMoviesBySearchCommand extends _$GetMoviesBySearchCommand{

  @override
  AsyncValue<List<Movie>> build() => AsyncLoading();

  Future<void> execute({required String query}) async {
    state = AsyncLoading();
    final searchUsecase = ref.read(getMoviesBySearchUsecaseProvider);
    final result = await  searchUsecase.execute(query: query);
    state = switch(result) {
      Success(: final value) => AsyncData(value),
      Failure() => AsyncError(Exception('Error in get movies by search'), StackTrace.current),
    };
  }

}