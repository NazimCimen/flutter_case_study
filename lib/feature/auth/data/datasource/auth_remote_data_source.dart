import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/core/constants/api_constants.dart';
import 'package:case_study/feature/shared/data/model/user_model.dart';
import 'package:case_study/core/error/error_handler.dart';
import 'package:case_study/config/localization/string_constants.dart';

abstract class AuthRemoteDataSource {
  /// Creates a new user account with email and password.
  /// Also sends email verification if possible.
  Future<Either<Failure, UserModel?>> signup({
    required String email,
    required String password,
    required String name,
  });

  /// Signs in user with email and password.
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  
  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, UserModel?>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.signupEndpoint}',
        data: {'email': email, 'name': name, 'password': password},
        options: Options(
          headers: {
            'Content-Type': ApiConstants.contentType,
            'Accept': ApiConstants.acceptHeader,
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final userData = responseData['data'] as Map<String, dynamic>;
        return Right(UserModel.fromJson(userData));
      } else {
        return Left(ServerFailure(errorMessage: StringConstants.signupFailed));
      }
    } on DioException catch (e) {
      return ErrorHandler.handleDioException(e).fold(
        (failure) => Left(failure),
        (_) =>
            Left(UnKnownFaliure(errorMessage: StringConstants.apiUnknownError)),
      );
    } catch (e) {
      return Left(
        UnKnownFaliure(errorMessage: StringConstants.apiUnknownError),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': ApiConstants.contentType,
            'Accept': ApiConstants.acceptHeader,
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final userData = responseData['data'] as Map<String, dynamic>;
        return Right(UserModel.fromJson(userData));
      } else {
        return Left(ServerFailure(errorMessage: StringConstants.loginFailed));
      }
    } on DioException catch (e) {
      return ErrorHandler.handleDioException(e).fold(
        (failure) => Left(failure),
        (_) =>
            Left(UnKnownFaliure(errorMessage: StringConstants.apiUnknownError)),
      );
    } catch (e) {
      return Left(
        UnKnownFaliure(errorMessage: StringConstants.apiUnknownError),
      );
    }
  }
}
