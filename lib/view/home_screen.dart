import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../vm/user_view_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<UserModel?>(
              future: userViewModel.fetchUserData(userViewModel.user?.userIdentifier ?? '', context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading state
                } else if (snapshot.hasError) {
                  return Text('Error fetching user data');
                } else if (!snapshot.hasData) {
                  return Text('No user data available');
                } else {
                  UserModel user = snapshot.data!;

                  return Card(
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User ID: ${user.userIdentifier}', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8.0),
                          Text('Name: ${user.name}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8.0),
                          if (user.userType == 'VENDOR') ...[
                            Text('Business Name: ${user.businessName}', style: TextStyle(fontSize: 16)),
                            Text('GST Number: ${user.gstNumber}', style: TextStyle(fontSize: 16)),
                            Text('Address: ${user.addressInfo?.address1}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 8.0),
                          ],
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await userViewModel.remove(); // Call logout method
                              Utils.snackBar('Logged out successfully', context);
                              Navigator.pushReplacementNamed(context, RoutesNames.login);
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
