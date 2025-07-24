import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/home/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MovieEntity>?>> getMovieList({int page = 1});
}
