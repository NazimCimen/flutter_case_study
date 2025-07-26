import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> updateProfileImage({
    required File imageFile,
  });
  
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies();
} 