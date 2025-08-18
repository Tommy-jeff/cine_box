import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/domain/models/favorite_movies.dart';

abstract interface class MoviesRepository {

  Future<Result<List<FavoriteMovie>>> getFavoriteMovies();

  Future<Result<Unit>> deleteFavoriteMovie({required int movieId});

  Future<Result<Unit>> saveFavoriteMovie({required FavoriteMovie favoriteMovie});
}