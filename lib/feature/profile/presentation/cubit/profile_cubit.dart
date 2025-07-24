import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/core/state/user_cubit.dart';
import 'package:case_study/core/state/user_state.dart';
import 'package:case_study/feature/profile/presentation/cubit/profile_state.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';
import 'package:case_study/config/theme/app_colors.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserCubit userCubit;

  ProfileCubit({required this.userCubit}) : super(const ProfileInitial()) {
    // Listen to UserCubit changes
    userCubit.stream.listen((userState) {
      _handleUserStateChange(userState);
    });
  }

  void _handleUserStateChange(UserState userState) {
    if (userState is UserLoaded) {
      emit(ProfileLoaded(userState.user));
    } else if (userState is UserInitial) {
      emit(const ProfileInitial());
    }
  }

  /// Load profile data from UserCubit
  void loadProfile() {
    final currentUser = userCubit.currentUser;
    if (currentUser != null) {
      emit(ProfileLoaded(currentUser));
    } else {
      emit(const ProfileError('User not found'));
    }
  }

  /// Update user profile
  void updateProfile(UserEntity updatedUser) {
    userCubit.updateUser(updatedUser);
  }

  /// Get current user from UserCubit
  UserEntity? get currentUser => userCubit.currentUser;

  /// Check if user is logged in
  bool get isLoggedIn => userCubit.isLoggedIn;

  Future<void> confirmPickedImage(File? image) async {
    if (image != null) {
      emit(ProfileImageUpdated(image));
    }
  }

  Future<void> removeProfileImage() async {
    emit(const ProfileImageUpdated(null));
  }

  Future<void> updateProfileImage(File image) async {
    /* final result = await userCubit.updateProfileImage(image);
    if (result) {
      emit(ProfileLoaded(userCubit.currentUser));
    }*/
  }
}
