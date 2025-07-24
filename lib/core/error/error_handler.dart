import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/feature/auth/data/model/user_model.dart';
import 'package:case_study/config/localization/string_constants.dart';
import 'package:flutter/foundation.dart';

/// Centralized error handling utility for API operations
@immutable
final class ErrorHandler {
  const ErrorHandler._();

  /// Handle DioException and return appropriate Failure
  static Either<Failure, void> handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Left(
          ConnectionFailure(errorMessage: StringConstants.connectionTimeout),
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      default:
        return Left(
          UnKnownFaliure(
            errorMessage: e.message ?? StringConstants.apiUnknownError,
          ),
        );
    }
  }

  /// Handle bad response (4xx, 5xx status codes)
  static Either<Failure, UserModel?> _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    switch (statusCode) {
      case 400:
        final errorMessage =
            responseData is Map && responseData['message'] != null
            ? responseData['message'].toString()
            : StringConstants.badRequest;
        return Left(ServerFailure(errorMessage: errorMessage));

      case 401:
        return Left(
          ServerFailure(errorMessage: StringConstants.invalidCredentials),
        );

      case 404:
        return Left(
          ServerFailure(errorMessage: StringConstants.apiUserNotFound),
        );

      case 409:
        return Left(
          ServerFailure(errorMessage: StringConstants.emailAlreadyExists),
        );

      case 422:
        return Left(
          ServerFailure(errorMessage: StringConstants.validationError),
        );

      case 500:
        return Left(
          ServerFailure(errorMessage: StringConstants.apiServerError),
        );

      default:
        return Left(
          ServerFailure(
            errorMessage:
                e.response?.statusMessage ?? StringConstants.apiServerError,
          ),
        );
    }
  }

  
}
