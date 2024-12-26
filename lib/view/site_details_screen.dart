import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/site_status_model.dart';
import '../models/user_model.dart';
import '../vm/site_view_model.dart';
import '../vm/user_view_model.dart';


class SiteDetailsScreen extends StatefulWidget {
  const SiteDetailsScreen({Key? key}) : super(key: key);

  @override
  _SiteDetailsScreenState createState() => _SiteDetailsScreenState();
}

class _SiteDetailsScreenState extends State<SiteDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  SiteStatus _selectedStatus = SiteStatus.ACTIVE;

  @override
  void initState() {
    super.initState();
    // Fetch site details once the widget is initialized
    Provider.of<SiteViewModel>(context, listen: false).fetchSiteDetails(context);
  }

  @override
  void dispose() {
    _nameController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siteViewModel = Provider.of<SiteViewModel>(context); // Use it only here
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Site Details'),
      ),
      body: siteViewModel.loading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (siteViewModel.siteDetails != null &&
                        siteViewModel.siteDetails!.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: siteViewModel.siteDetails!.length,
                        itemBuilder: (context, index) {
                          final site = siteViewModel.siteDetails![index];
                          return Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Site Identifier: ${site.siteIdentifier}',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text('Name: ${site.name}', style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 8),
                                  Text('Status: ${site.status.name}', style: TextStyle(fontSize: 16)),
                                  if (site.addressInfo != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Address: ${site.addressInfo!.address1}, ${site.addressInfo!.city}, ${site.addressInfo!.state}, ${site.addressInfo!.pincode}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    Form(
                      key: _formKey,
                      child: Card(
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create New Site',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Site Name',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a site name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              DropdownButtonFormField<SiteStatus>(
                                value: _selectedStatus,
                                items: SiteStatus.values
                                    .map((status) => DropdownMenuItem(
                                          value: status,
                                          child: Text(status.name),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStatus = value!;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Site Status',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              FutureBuilder<UserModel?>(
                                future: userViewModel.getUser(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error fetching user data');
                                  } else if (!snapshot.hasData || snapshot.data == null) {
                                    return Text('No user data available');
                                  } else {
                                    UserModel user = snapshot.data!;

                                    return ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          siteViewModel.createSite(
                                            _nameController.text.trim(),
                                            _selectedStatus,
                                            null, // You can add AddressInfo here if needed
                                            user.userIdentifier ?? '',
                                            context,
                                          );
                                        }
                                      },
                                      child: siteViewModel.loading
                                          ? CircularProgressIndicator(color: Colors.white)
                                          : Text('Create Site'),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
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
