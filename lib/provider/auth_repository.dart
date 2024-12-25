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
    return UserModel.fromJson(response);
  } catch (e) {
    throw Exception('Get user data failed: ${e.toString()}');
  }
}


}
