import 'package:case_study/feature/profile/presentation/widget/favorite_movie_card.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:case_study/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sliver widget for displaying the favorite movies section
class FavoriteMoviesSliverSection extends StatelessWidget {
  const FavoriteMoviesSliverSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Consistent horizontal padding for the entire page

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          // Show loading indicator while favorite movies are loading
          if (state.isLoadingFavoriteMovies) {
            return const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.white,
                    ),
                  ),
                ),
              ),
            );
          }
    
          // Show error if favorite movies failed to load
          if (state.favoriteMoviesError != null) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading favorite movies',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ProfileCubit>().loadFavoriteMovies(),
                        child: Text(StringConstants.retryButton),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
    
          // Show favorite movies if loaded
          if (state.favoriteMovies != null) {
            if (state.favoriteMovies!.isEmpty) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: AppColors.white.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz favori filminiz yok',
                          style: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.4),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
    
            return SliverList(
              delegate: SliverChildListDelegate([
                // Title
                Text(
                  StringConstants.likedMoviesTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
    
                // Movies Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                  itemCount: state.favoriteMovies!.length,
                  itemBuilder: (context, index) {
                    final movie = state.favoriteMovies![index];
                    return FavoriteMovieCard(
                      title: movie.title ?? 'Unknown Title',
                      studio: movie.description ?? 'Unknown Studio',
                      posterUrl: movie.posterUrl,
                    );
                  },
                ),
              ]),
            );
          }
        }
    
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
