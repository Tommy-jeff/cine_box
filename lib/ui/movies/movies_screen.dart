import 'package:cine_box/ui/movies/widgets/genres_box.dart';
import 'package:cine_box/ui/movies/widgets/movies_appbar.dart';
import 'package:cine_box/ui/movies/widgets/movies_by_category.dart';
import 'package:cine_box/ui/movies/widgets/movies_by_gender.dart';
import 'package:cine_box/ui/movies/widgets/movies_by_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesScreen extends ConsumerStatefulWidget {
  const MoviesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MoviesAppbar(),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: GenresBox(),
          ),
        ),
        SliverToBoxAdapter(
          child: MoviesBySearch(),
        )
      ],
    );
  }
}
