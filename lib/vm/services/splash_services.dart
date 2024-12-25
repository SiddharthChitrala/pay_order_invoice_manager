import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() async => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    try {
      final user = await getUserData();

      await Future.delayed(const Duration(seconds: 10));

      if (user.userIdentifier == null || user.userIdentifier!.isEmpty) {
        Navigator.pushNamed(context, RoutesNames.login);
      } else {
        Navigator.pushNamed(context, RoutesNames.home);
      }
    } catch (e) {
      print("Error in authentication check: $e");
    }
  }
}
