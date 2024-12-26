import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/site_info_model.dart';
import '../res/app_url.dart';

class SiteRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  // Method to create a new site
  Future<Site> createSite(
      Map<String, dynamic> data, String userIdentifier) async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'ACTION_PERFORMED_BY_USER': userIdentifier,
        'Content-Type': 'application/json',
      };
      final response = await _apiServices.getPostApiResponse(
        AppUrl.createSiteUrl, // Ensure this is the correct API endpoint
        data,
        headers: headers,
      );
      return Site.fromJson(response);
    } catch (e) {
      throw Exception(
          'Site creation failed: ${e.toString()}'); // Improved error message
    }
  }

  // Method to fetch site data
  Future<List<Site>> getSiteData() async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'Content-Type': 'application/json',
      };
      final response = await _apiServices.getGetApiResponse(
        AppUrl.getSiteUrl, // Use siteIdentifier correctly
        headers: headers,
      );

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        List<dynamic> data = response['data'];
        return data
            .map((siteJson) => Site.fromJson(siteJson))
            .toList(); // Map list of JSON to Site objects
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception(
          'Get site data failed: ${e.toString()}'); // Improved error message
    }
  }
}
