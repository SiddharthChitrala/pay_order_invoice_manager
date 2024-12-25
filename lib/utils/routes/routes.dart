import 'package:flutter/material.dart';
import 'package:pay_order_invoice_manager/view/home_screen.dart';

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
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text('No route defined')),
                ));
    }
  }
}
