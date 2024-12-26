import 'package:flutter/material.dart';
import '../models/purchase_order_model.dart';
import '../provider/purchase_order_repository.dart';

class PurchaseOrderViewModel with ChangeNotifier {
  final PurchaseOrderRepository _purchaseOrderRepo = PurchaseOrderRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<PurchaseOrder>? _purchaseOrders;
  List<PurchaseOrder>? get purchaseOrders => _purchaseOrders;

Future<void> fetchPurchaseOrders(String status) async {
  setLoading(true); // Set loading to true
  try {
    _purchaseOrders = await _purchaseOrderRepo.getPurchaseOrders(status); // Pass the status
    setLoading(false); // Set loading to false
  } catch (e) {
    setLoading(false); // Set loading to false
    print('Error fetching purchase orders: ${e.toString()}');
    throw Exception('Get Purchase Orders failed: ${e.toString()}');
  }
}


  Future<void> createPurchaseOrder(
    Map<String, dynamic> data,
    String userIdentifier,
    BuildContext context,
  ) async {
    setLoading(true);
    try {
      await _purchaseOrderRepo.createPurchaseOrder(data, userIdentifier);
      setLoading(false);
      Navigator.pop(context);
    } catch (e) {
      setLoading(false);
      print('Purchase order creation failed: ${e.toString()}');
    }
  }

  Future<void> updatePurchaseOrderStatus(
    String purchaseOrderId,
    String newStatus,
    String userIdentifier,
  ) async {
    setLoading(true);
    try {
      await _purchaseOrderRepo.updatePurchaseOrderStatus(
        purchaseOrderId,
        newStatus,
        userIdentifier,
      );
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print('Error updating purchase order status: ${e.toString()}');
    }
  }


}
