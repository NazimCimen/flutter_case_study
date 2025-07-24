import 'package:case_study/feature/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/home/domain/entity/movie_entity.dart';

final class GetMovieListUseCase {
  final HomeRepository repository;

  GetMovieListUseCase({required this.repository});

  Future<Either<Failure, List<MovieEntity>?>> call({int page = 1}) async {
    return repository.getMovieList(page: page);
  }
}
