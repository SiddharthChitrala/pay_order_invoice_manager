import 'material_model.dart';
import 'purshase_order_status_model.dart';

class PurchaseOrder {
  String? purchaseOrderIdentifier;
  String? siteName;
  String? approverId;
  String? approverName;
  String? vendorGstNumber;
  String? vendorBusinessName;
  List<Materials> materials; // List of Material objects
  double? totalPrice;
  PurchaseOrderStatus? status;
  String? purchaseOrderFileName;
  String? generatedOn;
  String? approvedOn;
  String? rejectedOn;

  PurchaseOrder({
    this.purchaseOrderIdentifier,
    this.siteName,
    this.approverId,
    this.approverName,
    this.vendorGstNumber,
    this.vendorBusinessName,
    required this.materials,
    this.totalPrice,
    this.status,
    this.purchaseOrderFileName,
    this.generatedOn,
    this.approvedOn,
    this.rejectedOn,
  });

  /// Deserialize JSON to a PurchaseOrder object
  PurchaseOrder.fromJson(Map<String, dynamic> json)
      : purchaseOrderIdentifier = json['purchase_order_identifier'],
        siteName = json['site_name'],
        approverId = json['approver_id'],
        approverName = json['approver_name'],
        vendorGstNumber = json['vendor_gst_number'],
        vendorBusinessName = json['vendor_business_name'],
        materials = (json['materials'] as List)
            .map((item) => Materials.fromJson(item))
            .toList(),
        totalPrice = json['total_price']?.toDouble(),
        status = json['status'] != null
            ? PurchaseOrderStatusExtension.fromJson(json['status'])
            : null,
        purchaseOrderFileName = json['purchase_order_file_name'],
        generatedOn = json['generated_on'],
        approvedOn = json['approved_on'],
        rejectedOn = json['rejected_on'];

  /// Serialize a PurchaseOrder object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['purchase_order_identifier'] = purchaseOrderIdentifier;
    data['site_name'] = siteName;
    data['approver_id'] = approverId;
    data['approver_name'] = approverName;
    data['vendor_gst_number'] = vendorGstNumber;
    data['vendor_business_name'] = vendorBusinessName;
    data['materials'] = materials.map((item) => item.toJson()).toList();
    data['total_price'] = totalPrice;
    data['status'] = status?.toJson(); // Convert enum to JSON
    data['purchase_order_file_name'] = purchaseOrderFileName;
    data['generated_on'] = generatedOn;
    data['approved_on'] = approvedOn;
    data['rejected_on'] = rejectedOn;
    return data;
  }
}
