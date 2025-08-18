import 'dart:async';

import 'package:cine_box/ui/core/themes/colors.dart';
import 'package:cine_box/ui/core/themes/resources.dart';
import 'package:cine_box/ui/movies/movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesAppbar extends ConsumerStatefulWidget {
  const MoviesAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesAppbarState();
}

class _MoviesAppbarState extends ConsumerState<MoviesAppbar> {
  Timer? _deBouce;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onSearchChanged() {
      final query = searchController.text;
      if (query.isEmpty) {
        _deBouce?.cancel();
        ref.read(moviesViewModelProvider.notifier).fetchMoviesByCategory();
        FocusScope.of(context).unfocus();
        return;
      }
      if (_deBouce?.isActive ?? false) _deBouce?.cancel();
      _deBouce = Timer(const Duration(milliseconds: 500), () {
        ref
            .read(moviesViewModelProvider.notifier)
            .fetchMoviesBySearch(query: query);
        FocusScope.of(context).unfocus();
      });
    }

    return SliverAppBar(
      expandedHeight: MediaQuery.sizeOf(context).height * 0.25,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          R.ASSETS_IMAGES_SMALL_BANNER_PNG,
          fit: BoxFit.cover,
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        title: SizedBox(
          height: 36,
          child: TextFormField(
            controller: searchController,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              hintText: 'Procurar filme',
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: 15,
                ),
              ),
              suffixIcon: Visibility(
                visible: searchController.text.isNotEmpty,
                child: IconButton(
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged();
                  },
                  icon: Icon(
                      Icons.clear,
                    size: 15,
                    color: AppColors.redColor,
                  ),
                ),
              ),
            ),
            onChanged: (_) => onSearchChanged(),
          ),
        ),
      ),
    );
  }
}
