import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../user_view_model.dart';

class SplashServices {
  /// Fetch user data using the `UserViewModel`.
  Future<UserModel?> getUserData() async {
    final userViewModel = UserViewModel();
    return await userViewModel.getUser();
  }

  /// Check authentication and navigate accordingly.
  void checkAuthentication(BuildContext context) async {
    try {
      // Retrieve user data
      final user = await getUserData();

      // Simulate splash delay
      await Future.delayed(const Duration(seconds: 3));

      // Navigate based on authentication status
      if (user == null || user.userIdentifier == null || user.userIdentifier!.isEmpty) {
        Navigator.pushReplacementNamed(context, RoutesNames.login);
      } else {
        Navigator.pushReplacementNamed(context, RoutesNames.home);
      }
    } catch (e) {
      print("Error in authentication check: $e");
      // Fallback to login screen on error
      Navigator.pushReplacementNamed(context, RoutesNames.login);
    }
  }
}
