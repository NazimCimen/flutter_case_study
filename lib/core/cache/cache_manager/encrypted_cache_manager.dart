import 'package:case_study/core/cache/cache_manager/base_cache_manager.dart';
import 'package:case_study/core/error/failure.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:dartz/dartz.dart';

/// Encrypted cache manager that uses AES encryption for sensitive data
class EncryptedCacheManager<T> extends BaseCacheManager<T> {
  final String boxName;
  final String encryptionKey;
  
  // Use a consistent IV for encryption/decryption
  static const String _fixedIV = '1234567890123456'; // 16 characters

  EncryptedCacheManager({required this.boxName, required this.encryptionKey});

  Future<Box<String>> _openBox() async {
    return Hive.openBox<String>(boxName);
  }

  /// Encrypt data using AES
  String _encryptData(String data) {
    try {
      final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, '0').substring(0, 32));
      final iv = encrypt.IV.fromUtf8(_fixedIV);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encrypted = encrypter.encrypt(data, iv: iv);
      return encrypted.base64;
    } catch (e) {
      rethrow;
    }
  }

  /// Decrypt data using AES
  String _decryptData(String encryptedData) {
    try {
      final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, '0').substring(0, 32));
      final iv = encrypt.IV.fromUtf8(_fixedIV);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
      return decrypted;
    } catch (e) {
      rethrow;
    }
  }

  /// Save encrypted data
  @override
  Future<Either<Failure, void>> saveData({
    required T data,
    required String keyName,
  }) async {
    try {
      final box = await _openBox();
      final dataString = data.toString();
      final encryptedData = _encryptData(dataString);
      await box.put(keyName, encryptedData);
      await box.close();
      return const Right(null);
    } catch (e) {
      return Left(UnKnownFaliure(errorMessage: 'Failed to save data'));
    }
  }

  /// Get and decrypt data
  @override
  Future<Either<Failure, T?>> getData({required String keyName}) async {
    try {
      final box = await _openBox();
      final encryptedData = box.get(keyName);
      await box.close();

      if (encryptedData == null) {
        return Left(UnKnownFaliure(errorMessage: 'No data found for key: $keyName'));
      }

      final decryptedData = _decryptData(encryptedData);
      
      // For String type, return directly
      if (T == String) {
        return Right(decryptedData as T);
      }
      
      // For other types, you might need custom parsing
      return Left(UnKnownFaliure(errorMessage: 'Unsupported type: $T'));
    } catch (e) {
      // If decryption fails, try to clear the corrupted data
      try {
        await clearData(keyName: keyName);
      } catch (clearError) {
        // Ignore clear error
      }
      return Left(UnKnownFaliure(errorMessage: 'Failed to get data'));
    }
  }

  /// Clear encrypted data
  @override
  Future<void> clearData({required String keyName}) async {
    final box = await _openBox();
    await box.delete(keyName);
    await box.close();
  }
}
