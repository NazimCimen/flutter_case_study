class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://caseapi.servicelabs.tech';

  // Auth Endpoints
  static const String loginEndpoint = '/user/login/';
  static const String signupEndpoint = '/user/register/';

  // Movie Endpoints
  static const String movieListEndpoint = '/movie/list';

  // Headers
  static const String contentType = 'application/json';
  static const String acceptHeader = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
}
