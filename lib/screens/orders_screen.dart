import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/orders_provider.dart';
import '../screens/order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: kBackgroundColor,
      body: orders.isEmpty
          ? Center(
        child: Text(
          'No orders available',
          style: TextStyle(color: kSecondaryColor, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            color: kCardColor,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: ListTile(
              title: Text(
                'Order ID: ${order.id}',
                style: TextStyle(color: kSecondaryColor, fontSize: 16),
              ),
              subtitle: Text(
                'Container: ${order.containerNumber}',
                style: TextStyle(
                    color: kSecondaryColor.withOpacity(0.7), fontSize: 14),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(order: order),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  'View Details',
                  style: TextStyle(color: kButtonTextColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
