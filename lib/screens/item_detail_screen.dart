import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/item.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;

  const ItemDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: kAppBarColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Возврат на предыдущий экран
          },
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Большое изображение товара
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              // Название товара
              Text(
                item.title,
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Производитель
              Text(
                'Страна-производитель: ${item.manufacturer}',
                style: TextStyle(
                  color: kSecondaryColor.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              // Цена товара
              Text(
                '\₽${item.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              // Количество на складе
              Text(
                'Количество на складе: ${item.quantity}',
                style: TextStyle(
                  color: item.quantity > 0 ? kSecondaryColor : kErrorColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              // Описание товара
              Text(
                item.description,
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
