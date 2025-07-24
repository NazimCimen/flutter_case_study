import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  /// Creates a new user account with email and password
  Future<Either<Failure, UserEntity?>> signup({
    required String email,
    required String password,
    required String name,
  });

  /// Signs in user with email and password
  Future<Either<Failure, UserEntity?>> login({
    required String email,
    required String password,
  });
}
