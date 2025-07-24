import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class StringConstants {
  static String get appName => 'Case Study';

  // Auth Başlıkları ve Alt Başlıkları - English Reading App'e uygun
  static String get loginTitle => 'loginTitle'.tr();
  static String get loginSubtitle => 'loginSubtitle'.tr();
  static String get emailLabel => 'emailLabel'.tr();
  static String get passwordLabel => 'passwordLabel'.tr();
  static String get confirmPasswordLabel => 'confirmPasswordLabel'.tr();
  static String get forgotPassword => 'forgotPassword'.tr();
  static String get loginButton => 'loginButton'.tr();
  static String get loginWithGoogle => 'loginWithGoogle'.tr();
  static String get noAccount => 'noAccount'.tr();
  static String get signUp => 'signUp'.tr();

  static String get signUpTitle => 'signUpTitle'.tr();
  static String get signUpSubtitle => 'signUpSubtitle'.tr();
  static String get nameLabel => 'nameLabel'.tr();
  static String get termsAgreement => 'termsAgreement'.tr();
  static String get termsAcceptance => 'termsAcceptance'.tr();
  static String get signUpButton => 'signUpButton'.tr();
  static String get signUpWithGoogle => 'signUpWithGoogle'.tr();
  static String get alreadyHaveAccount => 'alreadyHaveAccount'.tr();
  static String get login => 'login'.tr();

  // Bottom Bar Labels
  static String get homeTab => 'homeTab'.tr();
  static String get profileTab => 'profileTab'.tr();

  // Auth Messages -
  static String get successfullySignedIn => 'successfullySignedIn'.tr();
  static String get pleaseAcceptTerms => 'pleaseAcceptTerms'.tr();

  // Validation Messages
  static String get validationNameRequired => 'validationNameRequired'.tr();
  static String get validationNameInvalid => 'validationNameInvalid'.tr();
  static String get validationEmailRequired => 'validationEmailRequired'.tr();
  static String get validationEmailInvalid => 'validationEmailInvalid'.tr();
  static String get validationPasswordRequired =>
      'validationPasswordRequired'.tr();
  static String get validationPasswordMinLength =>
      'validationPasswordMinLength'.tr();
  static String get validationWordRequired => 'validationWordRequired'.tr();
  static String get validationWordMinLength => 'validationWordMinLength'.tr();
  static String get validationPartOfSpeechRequired =>
      'validationPartOfSpeechRequired'.tr();
  static String get validationDefinitionRequired =>
      'validationDefinitionRequired'.tr();

  // General Error Messages
  static String get requestTimeout => 'requestTimeout'.tr();
  static String get requestError => 'requestError'.tr();
  static String get firestoreError => 'firestoreError'.tr();

  // API Error Messages
  static String get connectionTimeout => 'connection_timeout'.tr();
  static String get apiUnknownError => 'unknown_error'.tr();
  static String get badRequest => 'bad_request'.tr();
  static String get invalidCredentials => 'invalid_credentials'.tr();
  static String get apiUserNotFound => 'user_not_found'.tr();
  static String get emailAlreadyExists => 'email_already_exists'.tr();
  static String get validationError => 'validation_error'.tr();
  static String get apiServerError => 'server_error'.tr();

  // Profile Detail Messages
  static String get profileDetailTitle => 'profileDetailTitle'.tr();
  static String get uploadPhotosTitle => 'uploadPhotosTitle'.tr();
  static String get uploadPhotosSubtitle => 'uploadPhotosSubtitle'.tr();
  static String get continueButton => 'continueButton'.tr();

  // Offer Sheet Header
  static String get offerSheetHeaderTitle => 'offerSheetHeaderTitle'.tr();
  static String get offerSheetHeaderSubtitle => 'offerSheetHeaderSubtitle'.tr();

  // Offer Sheet Bonuses Section
  static String get bonusesSectionTitle => 'bonusesSectionTitle'.tr();
  static String get bonusPremiumAccount => 'bonusPremiumAccount'.tr();
  static String get bonusMoreMatches => 'bonusMoreMatches'.tr();
  static String get bonusHighlight => 'bonusHighlight'.tr();
  static String get bonusMoreLikes => 'bonusMoreLikes'.tr();

  // Token Card Labels
  static String get tokenLabel => 'tokenLabel'.tr();
  static String get perWeekLabel => 'perWeekLabel'.tr();

  // Token Packages
  static String get selectTokenPackage => 'selectTokenPackage'.tr();

  // Offer Sheet Button
  static String get seeAllTokens => 'seeAllTokens'.tr();

  // Profile Image Crop
  static String get profileImageCropTitle => 'profileImageCropTitle'.tr();
} 