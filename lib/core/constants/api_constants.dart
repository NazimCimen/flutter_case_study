class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://caseapi.servicelabs.tech';

  // Auth Endpoints
  static const String loginEndpoint = '/user/login/';
  static const String signupEndpoint = '/user/register/';

  // Profile Endpoints
  static const String updateProfileImageEndpoint = '/user/upload_photo/';

  // Movie Endpoints
  static const String movieListEndpoint = '/movie/list';
  static const String toggleFavoriteEndpoint = '/movie/favorite';
  static const String favoriteMoviesEndpoint = '/movie/favorites';

  // Headers
  static const String contentType = 'application/json';
  static const String acceptHeader = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
}
