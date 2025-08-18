import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/movies/commands/get_movies_by_genre_command.dart';
import 'package:cine_box/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MoviesByGender extends ConsumerWidget {
  const MoviesByGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(getMoviesByGenreCommandProvider);

    return movies.when(
      loading: () => Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: AppColors.dartGrey,
            size: 60,
          ),
        ),
      ),
      data: (data) {
        return Container(
          padding: EdgeInsets.only(bottom: 130),
          child: MoviesBox(
            title: 'Filmes Encontrados pelo Gênero',
            vertical: true,
            movies: data,
          ),
        );
      },
      error: (error, stacktrace) => Center(
        child: Text('Nenhum filme neste gênero'),
      ),
    );
  }
}
