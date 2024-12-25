import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../vm/user_view_model.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          DropdownButton<String>(
            value: userViewModel.user?.userType ?? 'USER',
            items: ['USER', 'VENDOR', 'ADMIN', 'APPROVER']
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                userViewModel.fetchUsersByType(newValue);
              }
            },
          ),
        ],
      ),
      body: userViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : userViewModel.error.isNotEmpty
              ? Center(child: Text(userViewModel.error))
              : userViewModel.user != null
                  ? ListView.builder(
                      itemCount: 1, // Display only one user for simplicity
                      itemBuilder: (context, index) {
                        final user = userViewModel.user!;
                        return Card(
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User ID: ${user.userIdentifier}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('User Type: ${user.userType}'),
                                if (user.userType == 'VENDOR')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text('Business Name: ${user.businessName ?? "N/A"}'),
                                      Text('GST Number: ${user.gstNumber ?? "N/A"}'),
                                      Text(
                                          'Address: ${user.addressInfo?.address1 ?? "N/A"}, ${user.addressInfo?.city ?? "N/A"}, ${user.addressInfo?.state ?? "N/A"}, ${user.addressInfo?.pincode ?? "N/A"}'),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No user found')),
    );
  }
}
