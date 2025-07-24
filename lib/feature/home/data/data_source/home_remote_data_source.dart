import 'package:case_study/config/localization/string_constants.dart';
import 'package:case_study/core/error/error_handler.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/home/data/model/movie_model.dart';
import 'package:case_study/feature/home/domain/entity/movie_entity.dart';
import 'package:dio/dio.dart';
import 'package:case_study/core/constants/api_constants.dart';
import 'package:case_study/core/services/token_services.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<MovieEntity>?>> getMovieList({int page = 1});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio dio;
  final TokenService tokenService;

  HomeRemoteDataSourceImpl({required this.dio, required this.tokenService});

  @override
  Future<Either<Failure, List<MovieEntity>?>> getMovieList({
    int page = 1,
  }) async {
    try {
      // Get valid token from TokenService (with memory cache)
      final tokenResult = await tokenService.getToken();

      return tokenResult.fold((failure) => Left(failure), (token) async {
        final response = await dio.get(
          '${ApiConstants.baseUrl}${ApiConstants.movieListEndpoint}',
          queryParameters: {'page': page},
          options: Options(
            headers: {
              'Content-Type': ApiConstants.contentType,
              'Authorization': '${ApiConstants.bearerPrefix}$token',
            },
          ),
        );

        if (response.statusCode == 200) {
          final responseData = response.data as Map<String, dynamic>;
          final movieData = responseData['data'] as Map<String, dynamic>;
          final movies = movieData['movies'] as List<dynamic>;
          final moviesList = movies
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
