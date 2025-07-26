import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';

abstract class HomeRepository {
  /// Fetches movies with pagination
  Future<Either<Failure, List<MovieEntity>>> getMovieList({
    required int page,
  });

  /// Toggles favorite status of a movie
  Future<Either<Failure, bool>> toggleFavorite({
    required String movieId,
  });
}
