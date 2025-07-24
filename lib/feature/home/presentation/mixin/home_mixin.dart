import 'package:case_study/feature/home/domain/entity/movie_entity.dart';
import 'package:case_study/feature/home/presentation/cubit/home_cubit.dart';
import 'package:case_study/feature/home/presentation/cubit/home_state.dart';
import 'package:case_study/feature/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin HomeViewMixin on State<HomeView> {
  static const int pageSize = 5;
  final PagingController<int, MovieEntity> pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchPage(context, 1);

      pagingController.addPageRequestListener((pageKey) async {
        await fetchPage(context, pageKey);
      });
    });
  }

  Future<void> fetchPage(BuildContext context, int pageKey) async {
    await context.read<HomeCubit>().fetchMoviesPage(pageKey);
    if (context.mounted) {
      final state = context.read<HomeCubit>().state;
      if (state is HomeSuccess) {
        final movies = state.movies;
        final isLastPage = movies.length < HomeViewMixin.pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(movies);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(movies, nextPageKey);
        }
      } else if (state is HomeError) {
        pagingController.error = state.message;
      }
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
