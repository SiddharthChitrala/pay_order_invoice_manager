import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/purchase_order_model.dart';
import '../res/app_url.dart';

class PurchaseOrderRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  // Method to create a new Purchase Order
  Future<PurchaseOrder> createPurchaseOrder(
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
        AppUrl.createPurchaseOrderUrl, // API endpoint
        data,
        headers: headers,
      );
      return PurchaseOrder.fromJson(response);
    } catch (e) {
      throw Exception(
          'Purchase Order creation failed: ${e.toString()}');
    }
  }

  // Method to fetch all Purchase Orders
  Future<List<PurchaseOrder>> getPurchaseOrders(String status) async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'Content-Type': 'application/json',
      };
      final response = await _apiServices.getGetApiResponse(
        '${AppUrl.getPurchaseOrdersUrl}?purchaseOrderStatus=$status',
        headers: headers,
      );

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        List<dynamic> data = response['data'];
        return data
            .map((purchaseOrderJson) =>
                PurchaseOrder.fromJson(purchaseOrderJson))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Get Purchase Orders failed: ${e.toString()}');
    }
  }

  // Method to update the status of a Purchase Order
  Future<void> updatePurchaseOrderStatus(
      String purchaseOrderId, String newStatus, String userIdentifier) async {
    try {
      final headers = {
        'API_Client_Id': 'milestone',
        'API_Client_Secret': '1234567890',
        'businessIdentifier': 'milestone',
        'ACTION_PERFORMED_BY_USER': userIdentifier,
        'Content-Type': 'application/json',
      };
      final data = {
        'purchaseOrderFileId': purchaseOrderId,
        'status': newStatus,
      };

      await _apiServices.getPostApiResponse(
        '${AppUrl.updatePurchaseOrderStatusUrl}/$purchaseOrderId',
        data,
        headers: headers,
      );
    } catch (e) {
      throw Exception(
          'Update Purchase Order status failed: ${e.toString()}');
    }
  }


}
