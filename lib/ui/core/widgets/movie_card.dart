import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_box/ui/core/commands/favorite_movie_command.dart';
import 'package:cine_box/ui/core/commands/remove_favorite_movie_command.dart';
import 'package:cine_box/ui/core/commands/save_favorite_movie_command.dart';
import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/core/widgets/loader_messages.dart';
import 'package:cine_box/ui/core/widgets/movie_card_view_model.dart';
import 'package:cine_box/ui/movies/movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MovieCard extends ConsumerStatefulWidget {
  final int id;
  final String title;
  final int year;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const MovieCard({
    super.key,
    required this.id,
    required this.title,
    required this.year,
    required this.imageUrl,
    required this.isFavorite,
    this.onFavoriteTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieCardState();
}

class _MovieCardState extends ConsumerState<MovieCard> with LoaderAndMessages {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref
          .read(favoriteMovieCommandProvider(widget.id).notifier)
          .setFavorite(widget.isFavorite);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoriteMovieCommandProvider(widget.id));
    
    ref.listen(saveFavoriteMovieCommandProvider(widget.key!, widget.id), (_, next){
      next.whenOrNull(
        error: (error, stacktrace) {
          showErrorSnackBar('Desculpe, não foi possível favoritar o título');
        }
      );
    });

    ref.listen(removeFavoriteMovieCommandProvider(widget.key!, widget.id), (_, next){
      next.whenOrNull(
          error: (error, stacktrace) {
            showErrorSnackBar('Desculpe, não foi possível remover dos favoritos este título');
          }
      );
    });

    return Stack(
      children: [
        SizedBox(
          width: 148,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 148,
                    height: 184,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Container(
                    width: 148,
                    height: 184,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    child: Icon(Icons.error),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${widget.year}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGrey,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 50,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(30),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  ref
                      .read(
                        movieCardViewModelProvider(
                          widget.key!,
                          widget.id,
                        ).notifier,
                      )
                      .addOrRemoveFavorite(
                        id: widget.id,
                        title: widget.title,
                        posterPath: widget.imageUrl,
                        year: widget.year,
                        favorite: !isFavorite,
                      );
                },
                icon: isFavorite
                    ? Icon(Icons.favorite, size: 20)
                    : Icon(Icons.favorite_outline, size: 20),
                color: isFavorite ? AppColors.redColor : AppColors.lightGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
