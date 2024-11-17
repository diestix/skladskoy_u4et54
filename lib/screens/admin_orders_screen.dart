import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';
import '../constants/constants.dart';

class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Orders'),
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: kBackgroundColor,
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, index) {
          final order = ordersProvider.orders[index];

          return Card(
            color: kCardColor,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                'Order ${order.id}',
                style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Status: ${order.status}',
                style: TextStyle(color: kSecondaryColor.withOpacity(0.7)),
              ),
            ),
          );
        },
      ),
    );
  }
}
