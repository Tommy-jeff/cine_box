import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/repositories/repositories_providers.dart';
import 'package:cine_box/ui/core/commands/favorite_movie_command.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remove_favorite_movie_command.g.dart';

@riverpod
class RemoveFavoriteMovieCommand extends _$RemoveFavoriteMovieCommand {
  @override
  AsyncValue<int> build(Key key, int movieId) => AsyncData(movieId);

  Future<void> execute() async {
    final favoriteMovieCommand = ref.read(
      favoriteMovieCommandProvider(movieId).notifier,
    )..setFavorite(false);
    final favoriteRepository = ref.read(moviesRepositoryProvider);

    final result = await favoriteRepository.deleteFavoriteMovie(
      movieId: movieId,
    );

    switch (result) {
      case Success():
        log('favorite removed successfully');
      case Failure(:final error):
        favoriteMovieCommand.setFavorite(true);
        state = AsyncError(error, StackTrace.current);
    }
  }
}
