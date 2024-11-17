import 'package:flutter/material.dart';
import '../models/item.dart';
import '../constants/constants.dart';
import 'package:provider/provider.dart';
import '../providers/shipping_provider.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final shippingProvider = Provider.of<ShippingProvider>(context);

    return GestureDetector(
      onTap: () {
        // Можно открыть детальную страницу товара, если нужно
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor,
                    ),
                  ),
                  Text(
                    'Price: \$${item.price}',
                    style: TextStyle(
                      fontSize: 14,
                      color: kSecondaryColor.withOpacity(0.7),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          shippingProvider.removeItem(item.id);
                        },
                        icon: Icon(Icons.remove, color: kPrimaryColor),
                      ),
                      Text(
                        '${shippingProvider.getQuantity(item.id)}',
                        style: TextStyle(fontSize: 16, color: kPrimaryColor),
                      ),
                      IconButton(
                        onPressed: () {
                          shippingProvider.addItem(item.id);
                        },
                        icon: Icon(Icons.add, color: kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
