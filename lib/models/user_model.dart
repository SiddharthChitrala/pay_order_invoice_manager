import 'address_info_model.dart';

class UserModel extends AddressInfo{
  
  String? userIdentifier;
  String? otp;
  String? name;
  String? userType; // USER, ADMIN, APPROVER, VENDOR
  String? businessName; // Only for VENDOR
  String? gstNumber; // Only for VENDOR
  AddressInfo? addressInfo; // Only for VENDOR

  UserModel({
    this.userIdentifier,
    this.otp,
    this.name,
    this.userType,
    this.businessName,
    this.gstNumber,
    this.addressInfo,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userIdentifier = json['userIdentifier'];
    otp = json['otp'];
    name = json['name'];
    userType = json['userType'];
    businessName = json['businessName'];
    gstNumber = json['gstNumber'];
    addressInfo = json['addressInfo'] != null
        ? AddressInfo.fromJson(json['addressInfo'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userIdentifier'] = userIdentifier;
    data['otp'] = otp;
    data['name'] = name;
    data['userType'] = userType;
    data['businessName'] = businessName;
    data['gstNumber'] = gstNumber;
    data['addressInfo']=addressInfo;
    return data;
  }
}