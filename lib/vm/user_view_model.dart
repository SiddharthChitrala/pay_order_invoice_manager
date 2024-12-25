import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  /// Initialize SharedPreferences
  Future<SharedPreferences> _getSharedPreferences() async {
    return SharedPreferences.getInstance();
  }

  /// Save user data to SharedPreferences
  Future<bool> saveUser(UserModel user) async {
    final sp = await _getSharedPreferences();
    if (user.userIdentifier?.isNotEmpty == true) {
      return sp.setString('userIdentifier', user.userIdentifier!);
    } else {
      return false;
    }
  }

  /// Get user data from SharedPreferences
  Future<UserModel?> getUser() async {
    final sp = await _getSharedPreferences();
    final userIdentifier = sp.getString('userIdentifier');
    if (userIdentifier != null && userIdentifier.isNotEmpty) {
      return UserModel(userIdentifier: userIdentifier);
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




  /// Remove user data from SharedPreferences
  Future<bool> removeUser() async {
    final sp = await _getSharedPreferences();
    return sp.remove('userIdentifier');
  }
}
