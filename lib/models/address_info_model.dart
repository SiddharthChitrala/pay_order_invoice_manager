class AddressInfo {
  dynamic address1;
  String? city;
  String? state;
  dynamic pincode;

  AddressInfo({this.address1, this.city, this.state, this.pincode});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    return data;
  }
}
