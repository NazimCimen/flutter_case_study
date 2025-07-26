import 'package:case_study/core/services/token_services.dart';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/core/connection/network_info.dart';
import 'package:case_study/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:case_study/feature/shared/domain/entity/user_entity.dart';
import 'package:case_study/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;
  final TokenService tokenService;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.tokenService,
  });

  @override
  Future<Either<Failure, UserEntity?>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    if (await networkInfo.currentConnectivityResult) {
      final response = await remoteDataSource.signup(
        email: email,
        password: password,
        name: name,
      );

      // Handle token storage in repository layer
      return response.fold((failure) => Left(failure), (userModel) async {
        final token = userModel?.token;
        if (token != null && token.isNotEmpty) {
          final tokenResult = await tokenService.saveToken(token);
          return tokenResult.fold(
            (failure) => Left(failure),
            (_) => Right(userModel),
          );
        }
        return Right(userModel);
      });
    } else {
      return Left(ConnectionFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.currentConnectivityResult) {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      // Handle token storage in repository layer
      return response.fold((failure) => Left(failure), (userModel) async {
        final token = userModel?.token;
        if (token != null && token.isNotEmpty) {
          final tokenResult = await tokenService.saveToken(token);
          return tokenResult.fold(
            (failure) => Left(failure),
            (_) => Right(userModel),
          );
        }
        return Right(userModel);
      });
    } else {
      return Left(ConnectionFailure(errorMessage: 'No internet connection'));
    }
  }
}
