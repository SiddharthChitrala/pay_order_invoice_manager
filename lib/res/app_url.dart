class AppUrl {
  static const String baseUrl = 'http://localhost:8080/milestone-api';

  static const String loginUrl = '$baseUrl/services/v1/login';
  static const String getUserDataUrl = '$baseUrl/services/v1/user/';
  static const String createUserUrl = '$baseUrl/services/v1/user';
  static const String getUsersByTypeUrl = '$baseUrl/services/v1/users';
  static const String getSiteUrl = 'http://localhost:8080/milestone-api/services/v1/sites';
  static const String createSiteUrl = '$baseUrl/services/v1/site';
}
