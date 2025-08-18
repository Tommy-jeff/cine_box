import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/movies/commands/get_movies_by_search_command.dart';
import 'package:cine_box/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MoviesBySearch extends ConsumerWidget{
  const MoviesBySearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final movies = ref.watch(getMoviesBySearchCommandProvider);

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
        data: (data) => Container(
          padding: EdgeInsets.only(bottom: 130),
          child: MoviesBox(
            title: 'Filmes Encontrados na Busca',
            vertical: true,
            movies: data,
          ),
        ),
        error: (error, stacktrace) => Center(
          child: Text('Nenhum filme nesta pesquisa'),
        ),
       );
  }
}
