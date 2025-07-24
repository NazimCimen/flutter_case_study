import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/auth/domain/entity/user_entity.dart';
import 'package:case_study/feature/auth/domain/repository/auth_repository.dart';

final class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, UserEntity?>> call({
    required String email,
    required String password,
  }) async {
    return repository.login(email: email, password: password);
  }
}
