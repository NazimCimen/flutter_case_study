import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';

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

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];

  ProfileLoaded copyWith({UserEntity? user}) {
    return ProfileLoaded(user ?? this.user);
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileImageUpdated extends ProfileState {
  final File image;

  const ProfileImageUpdated(this.image);

  @override
  List<Object?> get props => [image];
}
