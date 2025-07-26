import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/profile/domain/usecase/update_profile_image_usecase.dart';
import 'package:case_study/feature/profile/domain/usecase/get_favorite_movies_usecase.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';
import 'package:case_study/feature/shared/state/user_cubit.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserCubit userCubit;
  final UpdateProfileImageUseCase updateProfileImageUseCase;
  final GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  ProfileCubit({
    required this.userCubit,
    required this.updateProfileImageUseCase,
    required this.getFavoriteMoviesUseCase,
  }) : super(const ProfileInitial());

  /// Load profile data from UserCubit
  void loadProfile() {
    final currentUser = userCubit.currentUser;
    if (currentUser != null) {
      emit(ProfileLoaded(currentUser));
      // Load favorite movies only if not already loaded
      if (!isFavoriteMoviesLoaded) {
        loadFavoriteMovies();
      }
    } else {
      emit(const ProfileError('User not found'));
    }
  }

  /// Update profile image
  Future<void> updateProfileImage(File? image) async {
    if (image == null) {
      emit(const ProfileError('Lütfen bir fotoğraf seçin'));
      return;
    }

    // Mevcut ProfileLoaded state'ini geçici olarak sakla
    final previousState = state is ProfileLoaded ? state as ProfileLoaded : null;

    emit(const ProfileLoading());

    final result = await updateProfileImageUseCase.call(imageFile: image);

    result.fold(
      (failure) {
        emit(ProfileError(failure.errorMessage));
      },
      (updatedUser) {
        // Update user in UserCubit
        userCubit.updateUser(updatedUser);
        
        if (previousState != null) {
          emit(previousState.copyWith(user: updatedUser));
        } else {
          emit(ProfileLoaded(updatedUser));
        }
      },
    );
  }

  /// Load favorite movies from API
  Future<void> loadFavoriteMovies() async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      // Don't load if already loading or already loaded
      if (currentState.isLoadingFavoriteMovies || 
          (currentState.favoriteMovies != null && currentState.favoriteMoviesError == null)) {
        return;
      }
      
      // Show loading state
      emit(currentState.copyWith(
        isLoadingFavoriteMovies: true,
        favoriteMoviesError: null,
      ));
    }

    final result = await getFavoriteMoviesUseCase.call();

    result.fold(
      (failure) {
        final currentState = state;
        if (currentState is ProfileLoaded) {
          emit(currentState.copyWith(
            isLoadingFavoriteMovies: false,
            favoriteMoviesError: failure.errorMessage,
          ));
        }
      },
      (movies) {
        final currentState = state;
        if (currentState is ProfileLoaded) {
          emit(currentState.copyWith(
            favoriteMovies: movies,
            isLoadingFavoriteMovies: false,
            favoriteMoviesError: null,
          ));
        }
      },
    );
  }

  /// Refresh profile data
  void refreshProfile() {
    loadProfile();
  }

  /// Get current user from UserCubit
  UserEntity? get currentUser => userCubit.currentUser;

  /// Check if user is logged in
  bool get isLoggedIn => userCubit.isLoggedIn;

  /// Get current favorite movies
  List<MovieEntity>? get currentFavoriteMovies {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      return currentState.favoriteMovies;
    }
    return null;
  }

  /// Check if favorite movies are loading
  bool get isFavoriteMoviesLoading {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      return currentState.isLoadingFavoriteMovies;
    }
    return false;
  }

  /// Check if favorite movies are loaded
  bool get isFavoriteMoviesLoaded {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      return currentState.favoriteMovies != null &&
          currentState.favoriteMoviesError == null;
    }
    return false;
  }

  /// Check if there was an error loading favorite movies
  bool get hasFavoriteMoviesError {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      return currentState.favoriteMoviesError != null;
    }
    return false;
  }

  /// Get favorite movies error message
  String? get favoriteMoviesErrorMessage {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      return currentState.favoriteMoviesError;
    }
    return null;
  }
}
