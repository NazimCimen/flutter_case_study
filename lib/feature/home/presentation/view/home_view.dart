import 'package:case_study/config/theme/app_colors.dart';
import 'package:case_study/core/utils/enum/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/home/domain/entity/movie_entity.dart';
import 'package:case_study/feature/home/presentation/cubit/home_cubit.dart';
import 'package:case_study/feature/home/presentation/cubit/home_state.dart';
import 'package:case_study/feature/home/presentation/mixin/home_mixin.dart';
part '../widget/content_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is HomeSuccess) {
          return PagedPageView<int, MovieEntity>(
            scrollDirection: Axis.vertical,
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
              itemBuilder: (context, movie, index) =>
                  _ContentWidget(movie: movie),
              firstPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              newPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              noItemsFoundIndicatorBuilder: (context) =>
                  const Center(child: Text('No content found')),
            ),
          );
        }
          return const SizedBox.shrink();
      },
    );
  }
}

