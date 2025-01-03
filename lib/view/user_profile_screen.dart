import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../utils/routes/routes_name.dart';
import '../vm/user_view_model.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel =
        Provider.of<UserViewModel>(context); // Provide the UserViewModel

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder<UserModel?>(
          future:
              userViewModel.fetchUserData(), // Use fetchUserData method here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Loading indicator
            } else if (snapshot.hasError) {
              return const Text('Error fetching user data');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No user data available');
            } else {
              UserModel user = snapshot.data!;

              return Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User ID: ${user.userIdentifier}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8.0),
                      Text('Name: ${user.name}',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8.0),
                      Text('User Type: ${user.userType}',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8.0),
                      if (user.userType == 'VENDOR') ...[
                        Text('Business Name: ${user.businessName}',
                            style: const TextStyle(fontSize: 16)),
                        Text('GST Number: ${user.gstNumber}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Address: ${user.addressInfo?.address1}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                      const SizedBox(height: 16.0),
                      // Conditional button for ADMIN and APPROVER
                      if (user.userType == 'ADMIN' ||
                          user.userType == 'APPROVER')
                        ElevatedButton(
                          onPressed: () {
                            // Action for the button
                            Navigator.pushNamed(
                                context, RoutesNames.createUserDetails);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Button pressed by ${user.userType}!'),
                              ),
                            );
                          },
                          child: const Text('Special Action'),
                        ),
                      const SizedBox(height: 16.0),
                      // Button to navigate to Home Screen
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesNames.home);
                        },
                        child: const Text('Home'),
                      ),
                      const SizedBox(height: 8.0),
                      // Button to navigate back to the User Profile Screen
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesNames.viewUserByType);
                        },
                        child: const Text('See user By Type'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
