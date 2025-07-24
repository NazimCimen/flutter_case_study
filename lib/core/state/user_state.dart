import 'package:equatable/equatable.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];

  UserLoaded copyWith({
    UserEntity? user,
  }) {
    return UserLoaded(
      user ?? this.user,
    );
  }
} 