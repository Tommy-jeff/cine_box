import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/movies/commands/get_genres_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GenresBox extends ConsumerWidget {
  var selectedGenre = ValueNotifier(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(getGenresCommandProvider);

    return genres.when(
      loading: () => Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: AppColors.dartGrey,
          size: 30,
        ),
      ),
      data: (data) {
        return SizedBox(
          height: 25,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var genre = data[index];

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                enableFeedback: false,
                onTap: () => selectedGenre.value = genre.id,
                child: ValueListenableBuilder(
                  valueListenable: selectedGenre,
                  builder: (BuildContext context, value, Widget? child) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: value == genre.id
                            ? AppColors.redColor
                            : AppColors.dartGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          genre.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
      error: (error, stacktrace) =>
          Center(child: Text('Error ao buscar gêneros')),
    );
  }
}
