import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/movies/commands/get_movies_by_category_command.dart';
import 'package:cine_box/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MoviesByCategory extends ConsumerWidget {
  const MoviesByCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(getMoviesByCategoryCommandProvider);

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
        if (data == null) {
          return Center(
            child: Text('Nenhum filme encontrado'),
          );
        }
        return Container(
          margin: EdgeInsets.only(bottom: 130),
          child: Column(
            children: [
              MoviesBox(
                title: 'Mais Populares',
                movies: data.popular,
              ),
              MoviesBox(
                title: 'Melhores Avaliados',
                movies: data.topRated,
              ),
              MoviesBox(
                title: 'Em Cartaz',
                movies: data.nowPlaying,
              ),
              MoviesBox(
                title: 'Em Breve',
                movies: data.upcoming,
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Padding(
        padding: EdgeInsets.all(20),
        child: Text('Erro ao buscar filmes'),
      ),
    );
  }
}
