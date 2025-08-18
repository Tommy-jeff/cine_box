import 'package:cine_box/data/repositories/repositories_providers.dart';
import 'package:cine_box/domain/usecases/get_movie_by_category_usecase.dart';
import 'package:cine_box/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:cine_box/domain/usecases/get_movies_by_search_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases_provider.g.dart';

@riverpod
GetMoviesByCategoryUsecase getMoviesByCategoryUsecase(Ref ref) {
  return GetMoviesByCategoryUsecase(
    moviesRepository: ref.read(moviesRepositoryProvider),
    tmdbRepository: ref.read(tmdbRepositoryProvider),
  );
}

@riverpod
GetMoviesByGenreUsecase getMoviesByGenreUsecase(Ref ref) {
  return GetMoviesByGenreUsecase(
    moviesRepository: ref.read(moviesRepositoryProvider),
    tmdbRepository: ref.read(tmdbRepositoryProvider),
  );
}

@riverpod
GetMoviesBySearchUsecase getMoviesBySearchUsecase(Ref ref) {
  return GetMoviesBySearchUsecase(
    moviesRepository: ref.read(moviesRepositoryProvider),
    tmdbRepository: ref.read(tmdbRepositoryProvider),
  );
}
