/// Encryption constants for secure data storage
class EncryptionConstants {
  const EncryptionConstants._();

  /// AES encryption key (32 characters required)
  /// In production, this should be stored securely (e.g., environment variables)
  static const String aesKey = 'CaseStudyApp2025SecureKey32Chars!@#';

  /// IV (Initialization Vector) length for AES
  static const int ivLength = 16;

  /// Key length for AES-256
  static const int keyLength = 32;
}
