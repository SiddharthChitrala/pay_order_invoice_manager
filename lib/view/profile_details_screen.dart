import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/address_info_model.dart';
import '../models/user_model.dart';
import '../vm/auth_view_model.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userTypeController = TextEditingController();
  final TextEditingController _userIdentifierController =
      TextEditingController();
      final TextEditingController _otpController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  String? _selectedUserType;

  // User types for dropdown
  final List<String> _userTypes = ['USER', 'ADMIN', 'APPROVER', 'VENDOR'];

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _userIdentifierController.dispose();
    _otpController.dispose();
    _userTypeController.dispose();
    _businessNameController.dispose();
    _gstNumberController.dispose();
    _address1Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Construct UserModel
      final user = UserModel(
        name: _nameController.text,
        userType: _selectedUserType,
        userIdentifier: _userIdentifierController.text,
        otp: _otpController.text,
        businessName:
            _selectedUserType == 'VENDOR' ? _businessNameController.text : null,
        gstNumber:
            _selectedUserType == 'VENDOR' ? _gstNumberController.text : null,
        addressInfo: _selectedUserType == 'VENDOR'
            ? AddressInfo(
                address1: _address1Controller.text,
                city: _cityController.text,
                state: _stateController.text,
                pincode: _pincodeController.text,
              )
            : null,
      );

      // Call AuthViewModel to create user
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.createUser(user, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Name is required' : null,
              ),

              TextFormField(
                controller: _userIdentifierController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) =>
                    value!.isEmpty ? 'Number is required' : null,
              ),
                    TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(labelText: 'Set Otp Number'),
                validator: (value) =>
                    value!.isEmpty ? 'Otp is required' : null,
              ),

              // User Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedUserType,
                items: _userTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUserType = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'User Type'),
                validator: (value) =>
                    value == null ? 'User type is required' : null,
              ),

              // Vendor-specific fields
              if (_selectedUserType == 'VENDOR') ...[
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _businessNameController,
                  decoration: const InputDecoration(labelText: 'Business Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Business name is required' : null,
                ),
                TextFormField(
                  controller: _gstNumberController,
                  decoration: const InputDecoration(labelText: 'GST Number'),
                  validator: (value) =>
                      value!.isEmpty ? 'GST number is required' : null,
                ),
                const SizedBox(height: 16.0),
                const Text('Address Information',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _address1Controller,
                  decoration: const InputDecoration(labelText: 'Address 1'),
                  validator: (value) =>
                      value!.isEmpty ? 'Address is required' : null,
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) =>
                      value!.isEmpty ? 'City is required' : null,
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: (value) =>
                      value!.isEmpty ? 'State is required' : null,
                ),
                TextFormField(
                  controller: _pincodeController,
                  decoration: const InputDecoration(labelText: 'Pincode'),
                  validator: (value) =>
                      value!.isEmpty ? 'Pincode is required' : null,
                ),
              ],

              // Submit Button
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: authViewModel.loading ? null : _submitForm,
                child: authViewModel.loading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                    : const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
