import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  final bool isLoading;
  AuthLoading(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final Failure failure;
  AuthError(this.failure);

  @override
  List<Object?> get props => [failure];
}
