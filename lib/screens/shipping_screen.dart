import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shipping_provider.dart';
import '../constants/constants.dart';
import '../data/dummy_data.dart';

class ShippingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shipping = Provider.of<ShippingProvider>(context);
    final items = shipping.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping'),
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? Center(
              child: Text(
                'No items in shipping.',
                style: TextStyle(color: kSecondaryColor, fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final itemId = items.keys.toList()[index];
                final quantity = items[itemId]!;
                final item = dummyItems.firstWhere((item) => item.id == itemId);

                return Card(
                  color: kCardColor,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: Icon(Icons.broken_image, size: 24, color: Colors.grey),
                        );
                      },
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Quantity: $quantity',
                      style: TextStyle(
                        color: kSecondaryColor.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: kErrorColor),
                      onPressed: () {
                        shipping.removeItem(itemId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} removed from shipping.'),
                            backgroundColor: kErrorColor,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  shipping.clear(); // Очистка выбранных товаров
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Выбранный товар успешно отправлен! 🎉',
                              style: TextStyle(
                                color: kSnackBarTextColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(Icons.check_circle, color: kSnackBarIconColor),
                        ],
                      ),
                      backgroundColor: kSnackBarBackgroundColor,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Confirm Shipping',
                  style: TextStyle(fontSize: 18, color: kButtonTextColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
