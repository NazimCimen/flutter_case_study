import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/core/connection/network_info.dart';
import 'package:case_study/feature/profile/data/datasource/profile_remote_data_source.dart';
import 'package:case_study/feature/profile/domain/repository/profile_repository.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/shared/domain/entity/movie_entity.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> updateProfileImage({
    required File imageFile,
  }) async {
    if (await networkInfo.currentConnectivityResult) {
      final result = await remoteDataSource.updateProfileImage(
        imageFile: imageFile,
      );
      return result.fold(
        (failure) => Left(failure),
        (userModel) => Right(userModel.toEntity()),
      );
    } else {
      return Left(ConnectionFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies() async {
    if (await networkInfo.currentConnectivityResult) {
      final result = await remoteDataSource.getFavoriteMovies();
      return result.fold((failure) => Left(failure), (movieModels) {
        if (movieModels == null) {
          return const Right([]);
        }
        return Right(movieModels.map((movie) => movie.toEntity()).toList());
      });
    } else {
      return Left(ConnectionFailure(errorMessage: 'No internet connection'));
    }
  }
}
