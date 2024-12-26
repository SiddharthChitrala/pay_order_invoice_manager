enum PurchaseOrderStatus { GENERATED, APPROVED, REJECTED }

extension PurchaseOrderStatusExtension on PurchaseOrderStatus {
  /// Converts the enum to a string for JSON serialization
  String toJson() => toString().split('.').last;

  /// Parses a string and converts it to the corresponding enum value
  static PurchaseOrderStatus fromJson(String value) {
    switch (value.toUpperCase()) {
      case 'APPROVED':
        return PurchaseOrderStatus.APPROVED;
      case 'REJECTED':
        return PurchaseOrderStatus.REJECTED;
      default:
        return PurchaseOrderStatus.GENERATED;
    }
  }
}
