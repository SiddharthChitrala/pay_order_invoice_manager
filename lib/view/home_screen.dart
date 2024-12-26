import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../vm/user_view_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder<UserModel?>(
          future: userViewModel.getUser(), // Fetch user from local data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Loading indicator
            } else if (snapshot.hasError) {
              return const Text('Error fetching user data'); // Error handling
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No user data available'); // No data fallback
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
                      const SizedBox(
                          height: 16), // Adds spacing between UI elements
                      ElevatedButton(
                        onPressed: () async {
                          bool success = await userViewModel
                              .removeUser(); // Clear user data
                          if (success) {
                            Utils.snackBar('Logged out successfully', context);
                            Navigator.pushReplacementNamed(
                                context, RoutesNames.login);
                          } else {
                            Utils.snackBar('Logout failed', context);
                          }
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
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesNames.profile);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.person, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Profile', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesNames.siteDetails);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.location_on_rounded, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Create Site', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesNames.purchaseOrderDetails);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.payment_rounded, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Create PO', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
