import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/order.dart';
import '../providers/shipping_provider.dart';
import '../data/dummy_data.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    final shipping = Provider.of<ShippingProvider>(context);

    // Найти данные о товаре из dummyData (если нужно)
    final item = dummyItems.firstWhere((i) => i.id == order.itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Item Type: ${order.itemType}', style: TextStyle(fontSize: 16, color: kSecondaryColor)),
            SizedBox(height: 8),
            Text('Container Number: ${order.containerNumber}', style: TextStyle(fontSize: 16, color: kSecondaryColor)),
            SizedBox(height: 8),
            Text('Item Name: ${item.title}', style: TextStyle(fontSize: 16, color: kSecondaryColor)),
            SizedBox(height: 8),
            Text('Required Quantity: ${order.requiredQuantity}', style: TextStyle(fontSize: 16, color: kSecondaryColor)),
            SizedBox(height: 16),
            Text(
              'Current Quantity: ${shipping.getQuantity(order.itemId)}',
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Проверка выполнения заказа
                final addedQuantity = shipping.getQuantity(order.itemId);
                if (addedQuantity >= order.requiredQuantity) {
                  shipping.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order completed successfully! 🎉'),
                      backgroundColor: kSnackBarBackgroundColor,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: Order not fulfilled correctly! ❌'),
                      backgroundColor: kErrorColor,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text('Complete Order', style: TextStyle(color: kButtonTextColor, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
