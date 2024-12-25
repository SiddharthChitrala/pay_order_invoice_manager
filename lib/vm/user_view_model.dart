import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/address_info_model.dart';
import '../models/user_model.dart';
import '../provider/auth_repository.dart';

class UserViewModel with ChangeNotifier {
  final AuthRepository _myRepo = AuthRepository();

  UserModel? _user; // Private field for the user
  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  String _error = '';
  String get error => _error;
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  /// Initialize SharedPreferences
  Future<SharedPreferences> _getSharedPreferences() async {
    return SharedPreferences.getInstance();
  }

  /// Save user data to SharedPreferences
  Future<bool> saveUser(UserModel user) async {
    final sp = await _getSharedPreferences();

    if (user.userIdentifier?.isNotEmpty == true) {
      // Save the common user details
      sp.setString('userIdentifier', user.userIdentifier!);

      // Save additional fields based on user type
      if (user.userType == 'VENDOR') {
        sp.setString('businessName', user.businessName!);
        sp.setString('gstNumber', user.gstNumber!);
        sp.setString('address1', user.addressInfo?.address1 ?? '');
        sp.setString('city', user.addressInfo?.city ?? '');
        sp.setString('state', user.addressInfo?.state ?? '');
        sp.setString('pincode', user.addressInfo?.pincode ?? '');
      }

      return true;
    } else {
      return false;
    }
  }

  /// Get user data from SharedPreferences
  Future<UserModel?> getUser() async {
    final sp = await _getSharedPreferences();

    final userIdentifier = sp.getString('userIdentifier');
    if (userIdentifier != null && userIdentifier.isNotEmpty) {
      final userType =
          sp.getString('userType'); // Retrieve userType from SharedPreferences

      if (userType == 'VENDOR') {
        final user = UserModel(
          userIdentifier: userIdentifier,
          userType: userType,
          businessName: sp.getString('businessName'),
          gstNumber: sp.getString('gstNumber'),
          addressInfo: AddressInfo(
            address1: sp.getString('address1')!,
            city: sp.getString('city')!,
            state: sp.getString('state')!,
            pincode: sp.getString('pincode')!,
          ),
        );
        return user;
      } else {
        // If userType is not 'VENDOR', just return the basic user
        return UserModel(userIdentifier: userIdentifier, userType: userType);
      }
    } else {
      print("UserIdentifier is null or empty");
      return null;
    }
  }

  Future<UserModel?> fetchUserData() async {
    try {
      final user = await getUser(); // Retrieve the stored user
      if (user != null) {
        print('UserIdentifier retrieved: ${user.userIdentifier}'); // Debug log

        // Fetch data using userIdentifier
        final fetchedUser = await _myRepo.getUserData(user.userIdentifier!);
        print('Fetched User Data: $fetchedUser'); // Debug log

        // Update the user data based on userType and save
        await saveUser(fetchedUser); // Save updated user data

        return fetchedUser; // Return full UserModel
      } else {
        print("User not found in SharedPreferences");
        throw Exception('User not found');
      }
    } catch (error) {
      print(
          'Error fetching user data: ${error.toString()}'); // Debugging the error
      return null;
    }
  }

  Future<void> fetchUsersByType(String userType) async {
    setLoading(true);
    try {
      final sharedPrefs = await _getSharedPreferences();
      final userIdentifier = sharedPrefs.getString('userIdentifier') ?? '';
      final users = await _myRepo.getUsersByType(userType, userIdentifier);
      print('Fetched Users: $users'); // Debug log
      setUser(users.isNotEmpty
          ? users.first
          : null); // Set the first user if available, else null
    } catch (e) {
      print('Error fetching users by type: ${e.toString()}'); // Log the error
      setError('Error fetching users: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Remove user data from SharedPreferences
  Future<bool> removeUser() async {
    final sp = await _getSharedPreferences();
    return sp.remove('userIdentifier');
  }
}
