import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../provider/auth_repository.dart';
import '../utils/utils.dart';

class UserViewModel with ChangeNotifier {
  final AuthRepository _myRepo = AuthRepository();

  UserModel? _user; // Define a private field for the user
  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  // Method to save user data
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (user.userIdentifier!.isNotEmpty) {
      return sp.setString('userIdentifier', user.userIdentifier.toString());
    } else {
      return false;
    }
  }

  // Method to get user data
  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userIdentifier = sp.getString('userIdentifier');
    if (userIdentifier?.isNotEmpty == true) {
      return UserModel(userIdentifier: userIdentifier!);
    } else {
      print("UserIdentifier is null or empty");
      return UserModel(userIdentifier: ''); // Return empty UserModel if null
    }
  }

  Future<UserModel?> fetchUserData(
      String userIdentifier, BuildContext context) async {
    try {
      // Ensure the method is GET
      final userData = await _myRepo.getUserData(userIdentifier);
      print('object');
      print(userData);
      setUser(userData); // Store user data in the ViewModel
      return userData;
    } catch (error) {
      Utils.snackBar('Failed to fetch user data: ${error.toString()}', context);
      print('Error fetching user data: ${error.toString()}');
      return null;
    }
  }

  // Method to remove user data
  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove('userIdentifier');
  }
}
