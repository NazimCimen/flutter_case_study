import 'package:case_study/feature/profile/presentation/widget/favorite_movie_card.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/size/constant_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget for displaying the favorite movies section
class FavoriteMoviesSection extends StatelessWidget {
  const FavoriteMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          // Show loading indicator while favorite movies are loading
          if (state.isLoadingFavoriteMovies) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          }

          // Show error if favorite movies failed to load
          if (state.favoriteMoviesError != null) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.errorLoadingFavoriteMovies,
                      style: const TextStyle(color: Colors.white),
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
            );
          }

          // Show favorite movies if loaded
          if (state.favoriteMovies != null) {
            if (state.favoriteMovies!.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        StringConstants.noFavoriteMoviesYet,
                        style: TextStyle(color: Colors.grey[400], fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.cMediumValue),

                  Text(
                    StringConstants.likedMoviesTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: context.cMediumValue),
                  Expanded(
                    child: GridView.builder(
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
                          title: movie.title ?? StringConstants.unknownTitle,
                          studio: movie.description ?? StringConstants.unknownStudio,
                          posterUrl: movie.posterUrl,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }

        return const Expanded(child: SizedBox.shrink());
      },
    );
  }
}
