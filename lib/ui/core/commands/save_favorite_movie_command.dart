import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/repositories/repositories_providers.dart';
import 'package:cine_box/domain/models/favorite_movies.dart';
import 'package:cine_box/ui/core/commands/favorite_movie_command.dart';
import 'package:cine_box/ui/core/widgets/loader_messages.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_favorite_movie_command.g.dart';

@riverpod
class SaveFavoriteMovieCommand extends _$SaveFavoriteMovieCommand {
  @override
  AsyncValue<int> build(Key key, int movieId) => AsyncData(movieId);

  Future<void> execute({
    required int id,
    required String title,
    required String posterPath,
    required int year,
  }) async {
    final favoriteMovieCommand = ref.read(
      favoriteMovieCommandProvider(id).notifier,
    )..setFavorite(true);

    final movieRepository = ref.read(moviesRepositoryProvider);
    var result = await movieRepository.saveFavoriteMovie(
      favoriteMovie: FavoriteMovie(
        id: id,
        posterPath: posterPath,
        title: title,
        year: year,
      ),
    );

    switch (result) {
      case Success():
        log('Favorite movie saved successfully');
      case Failure(:final error):
        favoriteMovieCommand.setFavorite(false);
        state = AsyncError(error, StackTrace.current);
    }
  }
}
