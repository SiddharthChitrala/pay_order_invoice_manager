import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

import '../vm/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                focusNode: phoneFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, phoneFocusNode, otpFocusNode);
                },
              ),
              SizedBox(height: height * 0.07),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                focusNode: otpFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP',
                  labelText: 'OTP',
                  prefixIcon: Icon(Icons.lock),
                  // obscureText: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * .1),
              RoundButton(
                title: 'Login',
                loading: authViewModel.loading,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    final userIdentifier = _phoneController.text;
                    final otp = _otpController.text;

                    authViewModel.loginApi(userIdentifier, otp, context);
                  }
                },
              ),
              SizedBox(height: height * 0.04),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, '/signup'); // Replace with your route
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Don’t have an account? ',
                    style:
                        TextStyle(color: AppColors.blackColor, fontSize: 16.0),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
