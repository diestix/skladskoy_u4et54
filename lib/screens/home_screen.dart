import 'package:flutter/material.dart';
import '../data/dummy_data.dart'; // Подключение списка товаров
import '../widgets/item_card.dart';
import '../constants/constants.dart'; // Подключение файла constants

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: kAppBarColor, // Использование цвета из constants
      ),
      backgroundColor: kBackgroundColor, // Использование фонового цвета из constants
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Сетка из двух колонок
          childAspectRatio: 3 / 4, // Соотношение сторон для карточек
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: dummyItems.length,
        itemBuilder: (context, index) {
          final item = dummyItems[index];
          return ItemCard(item: item); // Передача данных в карточку
        },
      ),
    );
  }
}
