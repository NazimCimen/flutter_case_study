import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/shared/state/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  /// Set user data
  void setUser(UserEntity user) {
    emit(UserLoaded(user));
  }

  /// Clear user data (logout)
  void clearUser() {
    emit(const UserInitial());
  }

  /// Update user data
  void updateUser(UserEntity user) {
    emit(UserLoaded(user));
  }

  /// Get current user (if loaded)
  UserEntity? get currentUser {
    if (state is UserLoaded) {
      return (state as UserLoaded).user;
    }
    return null;
  }

  /// Check if user is logged in
  bool get isLoggedIn => state is UserLoaded;
} 