import 'package:equatable/equatable.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final List<MovieEntity>? favoriteMovies;
  final bool isLoadingFavoriteMovies;
  final String? favoriteMoviesError;

  const ProfileLoaded(
    this.user, {
    this.favoriteMovies,
    this.isLoadingFavoriteMovies = false,
    this.favoriteMoviesError,
  });

  @override
  List<Object?> get props => [user, favoriteMovies, isLoadingFavoriteMovies, favoriteMoviesError];

  ProfileLoaded copyWith({
    UserEntity? user,
    List<MovieEntity>? favoriteMovies,
    bool? isLoadingFavoriteMovies,
    String? favoriteMoviesError,
  }) {
    return ProfileLoaded(
      user ?? this.user,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      isLoadingFavoriteMovies: isLoadingFavoriteMovies ?? this.isLoadingFavoriteMovies,
      favoriteMoviesError: favoriteMoviesError ?? this.favoriteMoviesError,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}


