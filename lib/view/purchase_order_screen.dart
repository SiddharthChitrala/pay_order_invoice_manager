import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../vm/purchase_order_view_model.dart';

class PurchaseOrderScreen extends StatefulWidget {
  @override
  _PurchaseOrderScreenState createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch purchase orders when the screen is first opened
    context.read<PurchaseOrderViewModel>().fetchPurchaseOrders('some-status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Orders'),
      ),
      body: Consumer<PurchaseOrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.purchaseOrders != null && viewModel.purchaseOrders!.isNotEmpty) {
            return ListView.builder(
              itemCount: viewModel.purchaseOrders!.length,
              itemBuilder: (context, index) {
                final purchaseOrder = viewModel.purchaseOrders![index];
                return ListTile(
                  title: Text('Order ID: ${purchaseOrder.approverName}'),
                  subtitle: Text('Status: ${purchaseOrder.status}'),
                );
              },
            );
          } else {
            return Center(child: Text('No Purchase Orders found.'));
          }
        },
      ),
    );
  }
}
