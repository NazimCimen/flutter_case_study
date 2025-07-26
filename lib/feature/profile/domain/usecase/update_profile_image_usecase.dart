import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/profile/domain/repository/profile_repository.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';

final class UpdateProfileImageUseCase {
  final ProfileRepository repository;

  UpdateProfileImageUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required File imageFile,
  }) async {
    return repository.updateProfileImage(imageFile: imageFile);
  }
} 