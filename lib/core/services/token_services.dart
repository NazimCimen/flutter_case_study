// lib/core/services/token_service.dart
import 'package:dartz/dartz.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:case_study/core/cache/cache_manager/encrypted_cache_manager.dart';
import 'package:case_study/core/cache/cache_enum.dart';
import 'package:case_study/core/cache/encryption_constants.dart';

/// Centralized token management service
/// Provides global access to token operations with memory caching
abstract class TokenService {
  /// Get current authentication token
  Future<Either<Failure, String?>> getToken();

  /// Save authentication token
  Future<Either<Failure, void>> saveToken(String token);

  /// Clear authentication token (logout)
  Future<Either<Failure, void>> clearToken();

  /// Clear memory cache (useful for logout or token refresh)
  void clearCache();
}

class TokenServiceImpl implements TokenService {
  late final EncryptedCacheManager<String> _tokenCache;

  // Memory cache for performance optimization
  String? _cachedToken;
  DateTime? _cacheExpiry;
  static const Duration _cacheDuration = Duration(minutes: 30);

  TokenServiceImpl() {
    _tokenCache = EncryptedCacheManager<String>(
      boxName: CacheHiveBoxEnum.secureStorage.name,
      encryptionKey: EncryptionConstants.aesKey,
    );
  }

  @override
  Future<Either<Failure, String?>> getToken() async {
    // Check memory cache first for better performance
    if (_cachedToken != null &&
        _cacheExpiry != null &&
        DateTime.now().isBefore(_cacheExpiry!)) {
      return Right(_cachedToken);
    }

    // If not in memory cache, get from encrypted storage
    try {
      final token = await _tokenCache.getData(
        keyName: CacheKeyEnum.authToken.name,
      );

      return token.fold((failure) => Left(failure), (token) {
        // Cache in memory for future requests
        if (token != null && token.isNotEmpty) {
          _cachedToken = token;
          _cacheExpiry = DateTime.now().add(_cacheDuration);
        }
        return Right(token);
      });
    } catch (e) {
      return Left(UnKnownFaliure(errorMessage: 'Failed to get token'));
    }
  }

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _tokenCache.saveData(
        data: token,
        keyName: CacheKeyEnum.authToken.name,
      );

      // Update memory cache immediately
      _cachedToken = token;
      _cacheExpiry = DateTime.now().add(_cacheDuration);
      
      return const Right(null);
    } catch (e) {
      return Left(UnKnownFaliure(errorMessage: 'Failed to save token'));
    }
  }

  @override
  Future<Either<Failure, void>> clearToken() async {
    try {
      await _tokenCache.clearData(keyName: CacheKeyEnum.authToken.name);
      clearCache();
      return const Right(null);
    } catch (e) {
      return Left(UnKnownFaliure(errorMessage: 'Failed to clear token'));
    }
  }

  @override
  void clearCache() {
    _cachedToken = null;
    _cacheExpiry = null;
  }
}
