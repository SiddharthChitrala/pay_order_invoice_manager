import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../provider/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(
      String userIdentifier, String otp, BuildContext context) async {
    setLoading(true);

    try {
      final data = {'userIdentifier': userIdentifier, 'otp': otp};
      final user = await _myRepo.loginApi(data);

      // Save userIdentifier and otp to SharedPreferences
      await _saveLoginData(userIdentifier, otp);

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(userIdentifier: user.userIdentifier));

      setLoading(false);
      Utils.snackBar('You have logged in successfully.', context);
      Navigator.pushReplacementNamed(context, RoutesNames.home);
    } catch (e) {
      setLoading(false);
      Utils.snackBar(e.toString(), context);
    }
  }

  // Method to save userIdentifier and otp to SharedPreferences
  Future<void> _saveLoginData(String userIdentifier, String otp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userIdentifier', userIdentifier);
    await prefs.setString('otp', otp);
  }

  // Method to retrieve saved login data
  Future<Map<String, String>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final userIdentifier = prefs.getString('userIdentifier') ?? '';
    final otp = prefs.getString('otp') ?? '';
    return {'userIdentifier': userIdentifier, 'otp': otp};
  }

  Future<void> createUser(UserModel user, BuildContext context) async {
    setLoading(true);

    try {
      // Retrieve the current userIdentifier from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final userIdentifier = prefs.getString('userIdentifier') ?? '';

      // Call the repository to create the user
      await _myRepo.createUser(user, userIdentifier);

      setLoading(false);
      Utils.snackBar('User created successfully!', context);
      Navigator.pop(context); // Navigate back after creation
    } catch (e) {
      setLoading(false);
      Utils.snackBar('Error: ${e.toString()}', context);
    }
  }
}
