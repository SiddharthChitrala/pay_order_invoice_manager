class AppUrl {
  static const String baseUrl = 'http://localhost:8080/milestone-api';

  static const String loginUrl = '$baseUrl/services/v1/login';
  static const String getUserDataUrl = '$baseUrl/services/v1/user/';
  static const String createUserUrl = '$baseUrl/services/v1/user';
  static const String getUsersByTypeUrl = '$baseUrl/services/v1/users';
  static const String getSiteUrl = '$baseUrl/services/v1/sites';
  static const String createSiteUrl = '$baseUrl/services/v1/site';

  static const String createPurchaseOrderUrl = '$baseUrl/services/v1/purchaseorder';
  static const String getPurchaseOrdersUrl = '$baseUrl/services/v1/purchaseorders';
  static const String uploadPurchaseOrderFileUrl = '$baseUrl/services/v1/upload/';
  static const String updatePurchaseOrderStatusUrl = '$baseUrl/services/v1/purchaseorder/';
}
