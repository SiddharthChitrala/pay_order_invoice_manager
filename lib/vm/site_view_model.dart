import 'package:flutter/material.dart';
import '../models/address_info_model.dart';
import '../models/site_info_model.dart';
import '../models/site_status_model.dart';
import '../provider/site_details_repository.dart';

class SiteViewModel with ChangeNotifier {
  final SiteRepository _siteRepo = SiteRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Site>? _siteDetails;
  List<Site>? get siteDetails => _siteDetails;

  Future<void> fetchSiteDetails(BuildContext context) async {
    setLoading(true);
    try {
      _siteDetails =
          await _siteRepo.getSiteData(); // Assign fetched data to _siteDetails
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print(
          'Error fetching site details: ${e.toString()}'); // Improve error handling
    }
  }

  Future<void> createSite(
      String name,
      SiteStatus status,
      AddressInfo? addressInfo,
      String userIdentifier,
      BuildContext context) async {
    setLoading(true);
    try {
      final site = Site.withCurrentTimestamp(
        name: name,
        status: status,
        addressInfo: addressInfo,
      );
      await _siteRepo.createSite(site.toJson(), userIdentifier);
      setLoading(false);
      Navigator.pop(context); // Navigate back after site creation
    } catch (e) {
      setLoading(false);
      print('Site creation failed: ${e.toString()}'); // Improved error message
    }
  }
}
