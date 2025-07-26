import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/home/domain/repository/home_repository.dart';

final class ToggleFavoriteUseCase {
  final HomeRepository repository;

  ToggleFavoriteUseCase({required this.repository});

  Future<Either<Failure, bool>> call({
    required String movieId,
  }) async {
    return repository.toggleFavorite(movieId: movieId);
  }
} 