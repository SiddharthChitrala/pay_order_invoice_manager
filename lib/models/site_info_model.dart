import 'address_info_model.dart';
import 'site_status_model.dart';
import 'package:intl/intl.dart';

class Site {
  final String siteIdentifier;
  final String name;
  final SiteStatus status;
  final AddressInfo? addressInfo;

  Site({
    required this.siteIdentifier,
    required this.name,
    required this.status,
    this.addressInfo,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      siteIdentifier: json['siteIdentifier'],
      name: json['name'],
      status: SiteStatus.values.firstWhere(
        (e) => e.toString() == 'SiteStatus.${json['status']}',
      ),
      addressInfo: json['addressInfo'] != null
          ? AddressInfo.fromJson(json['addressInfo'])
          : null,
    );
  }

  factory Site.withCurrentTimestamp({
    required String name,
    required SiteStatus status,
    AddressInfo? addressInfo,
  }) {
    final String currentTimestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    return Site(
      siteIdentifier: currentTimestamp,
      name: name,
      status: status,
      addressInfo: addressInfo,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['siteIdentifier'] = siteIdentifier;
    data['name'] = name;
    data['status'] = status.toString().split('.').last; // Ensure status is correctly serialized
    if (addressInfo != null) {
      data['addressInfo'] = addressInfo!.toJson(); // Ensure toJson() is called safely
    }

    return data;
  }
}
