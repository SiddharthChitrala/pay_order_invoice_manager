import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/user_model.dart';
import '../res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> loginApi(Map<String, dynamic> data) async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'Content-Type': 'application/json',
      };
      final response = await _apiServices.getPostApiResponse(
        AppUrl.loginUrl,
        data,
        headers: headers,
      );
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<UserModel> getUserData(String userIdentifier) async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'Content-Type': 'application/json',
      };
      final response = await _apiServices.getGetApiResponse(
        '${AppUrl.getUserDataUrl}$userIdentifier',
        headers: headers,
      );
      return UserModel.fromJson(
          response); // Ensure this returns the full UserModel
    } catch (e) {
      throw Exception('Get user data failed: ${e.toString()}');
    }
  }

  Future<void> createUser(UserModel user, String userIdentifier) async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'ACTION_PERFORMED_BY_USER': userIdentifier,
        'Content-Type': 'application/json',
      };
      final response = await _apiServices.getPostApiResponse(
        AppUrl.createUserUrl, // Define the endpoint in AppUrl
        user.toJson(),
        headers: headers,
      );
      print('User creation response: $response');
    } catch (e) {
      throw Exception('User creation failed: ${e.toString()}');
    }
  }

  Future<List<UserModel>> getUsersByType(String userType , String userIdentifier ) async {
    final headers = {
      'API_Client_Id': 'milestone',
      'API_Client_Secret': '1234567890',
      'businessIdentifier': 'milestone',
      'Content-Type': 'application/json',
      'ACTION_PERFORMED_BY_USER': userIdentifier,
    };
    final response = await _apiServices.getPostApiResponse(
      AppUrl.getUsersByTypeUrl, // Ensure this endpoint accepts POST
      {'userType': userType},
      headers: headers,
    );
    return (response as List).map((data) => UserModel.fromJson(data)).toList();
  }
}
