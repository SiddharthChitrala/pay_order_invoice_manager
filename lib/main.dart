import 'package:flutter/material.dart';
import 'package:pay_order_invoice_manager/utils/routes/routes.dart';
import 'package:pay_order_invoice_manager/utils/routes/routes_name.dart';
import 'package:pay_order_invoice_manager/vm/site_view_model.dart';

import 'package:provider/provider.dart';

import 'vm/auth_view_model.dart';
import 'vm/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserViewModel(),
          ),
          ChangeNotifierProvider(create: (_) => SiteViewModel()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesNames.splash,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
