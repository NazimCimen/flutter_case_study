import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/auth/domain/repository/auth_repository.dart';

final class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase({required this.repository});

  Future<Either<Failure, UserEntity?>> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return repository.signup(email: email, password: password, name: name);
  }
}
