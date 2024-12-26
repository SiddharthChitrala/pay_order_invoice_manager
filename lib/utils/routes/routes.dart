import 'package:flutter/material.dart';
import 'package:pay_order_invoice_manager/view/home_screen.dart';
import 'package:pay_order_invoice_manager/view/profile_details_screen.dart';
import 'package:pay_order_invoice_manager/view/site_details_screen.dart';
import 'package:pay_order_invoice_manager/view/user_profile_screen.dart';
import 'package:pay_order_invoice_manager/view/user_type_def_screen.dart';

import '../../view/login_screen.dart';
import '../../view/splash_screen.dart';
import 'routes_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesNames.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesNames.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserProfileScreen());
      case RoutesNames.createUserDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => CreateUserScreen());
      case RoutesNames.viewUserByType:
        return MaterialPageRoute(
            builder: (BuildContext context) => UsersScreen());
            case RoutesNames.siteDetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => SiteDetailsScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text('No route defined')),
                ));
    }
  }
}
