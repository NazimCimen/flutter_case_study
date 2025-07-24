import 'package:case_study/feature/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/home/domain/entity/movie_entity.dart';
import 'package:case_study/core/connection/network_info.dart';
import 'package:case_study/feature/home/data/data_source/home_remote_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  final INetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MovieEntity>?>> getMovieList({
    int page = 1,
  }) async {
    if (await networkInfo.currentConnectivityResult) {
      return remoteDataSource.getMovieList(page: page);
    } else {
      return Left(ConnectionFailure(errorMessage: 'No internet connection'));
    }
  }
}
