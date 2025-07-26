import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/core/connection/network_info.dart';
import 'package:case_study/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:case_study/feature/home/domain/repository/home_repository.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';
import 'package:case_study/config/localization/string_constants.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovieList({
    required int page,
  }) async {
    if (await networkInfo.currentConnectivityResult) {
      final result = await remoteDataSource.getMovieList(page: page);
      return result.fold(
        (failure) => Left(failure),
        (movies) =>
            Right(movies?.map((movie) => movie.toEntity()).toList() ?? []),
      );
    } else {
      return Left(ConnectionFailure(errorMessage: StringConstants.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite({
    required String movieId,
  }) async {
    if (await networkInfo.currentConnectivityResult) {
      return await remoteDataSource.toggleFavorite(movieId: movieId);
    } else {
      return Left(ConnectionFailure(errorMessage: StringConstants.noInternetConnection));
    }
  }
}
