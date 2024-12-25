import 'package:flutter/material.dart';
import '../vm/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context); // Call authentication check
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
