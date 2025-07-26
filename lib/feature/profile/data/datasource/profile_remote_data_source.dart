import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/core/constants/api_constants.dart';
import 'package:case_study/core/error/error_handler.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/services/token_services.dart';
import 'package:case_study/feature/shared/data/model/user_model.dart';
import 'package:case_study/feature/shared/data/model/movie_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, UserModel>> updateProfileImage({
    required File imageFile,
  });

  Future<Either<Failure, List<MovieModel>?>> getFavoriteMovies();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;
  final TokenService tokenService;

  ProfileRemoteDataSourceImpl({required this.dio, required this.tokenService});

  @override
  Future<Either<Failure, UserModel>> updateProfileImage({
    required File imageFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_image.jpg',
        ),
      });

      final tokenResult = await tokenService.getToken();
      return tokenResult.fold((failure) => Left(failure), (token) async {
        final response = await dio.post(
          '${ApiConstants.baseUrl}${ApiConstants.updateProfileImageEndpoint}',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Accept': ApiConstants.acceptHeader,
              'Authorization': '${ApiConstants.bearerPrefix}$token',
            },
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = response.data as Map<String, dynamic>;
          final userData = responseData['data'] as Map<String, dynamic>;
          return Right(UserModel.fromJson(userData));
        } else {
          return Left(
            ServerFailure(errorMessage: 'Profile image update failed'),
          );
        }
      });
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
  Future<Either<Failure, List<MovieModel>?>> getFavoriteMovies() async {
    try {
      final tokenResult = await tokenService.getToken();
      return tokenResult.fold((failure) => Left(failure), (token) async {
        final response = await dio.get(
          '${ApiConstants.baseUrl}${ApiConstants.favoriteMoviesEndpoint}',
          options: Options(
            headers: {
              'Content-Type': ApiConstants.contentType,
              'Accept': ApiConstants.acceptHeader,
              'Authorization': '${ApiConstants.bearerPrefix}$token',
            },
          ),
        );

        if (response.statusCode == 200) {
          final responseData = response.data as Map<String, dynamic>;
          final movieData = responseData['data'] as List<dynamic>;
          final moviesList = movieData
              .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Right(moviesList);
        } else {
          return Left(ServerFailure(errorMessage: 'Failed to load movies'));
        }
      });
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
