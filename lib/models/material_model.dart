class Materials {
  String? name;
  String? quantity;
  String? packingType;
  String? details;
  double? purchasePrice;

  Materials({
    this.name,
    this.quantity,
    this.packingType,
    this.details,
    this.purchasePrice,
  });

  Materials.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'],
        packingType = json['packing_type'],
        details = json['details'],
        purchasePrice = json['purchase_price']?.toDouble();

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'packing_type': packingType,
        'details': details,
        'purchase_price': purchasePrice,
      };
}

