import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/profile/domain/repository/profile_repository.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';

final class GetFavoriteMoviesUseCase {
  final ProfileRepository repository;

  GetFavoriteMoviesUseCase({required this.repository});

  Future<Either<Failure, List<MovieEntity>>> call() async {
    return repository.getFavoriteMovies();
  }
} 