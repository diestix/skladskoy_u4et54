import 'package:flutter/material.dart';
import 'package:newkursach/screens/admin_orders_screen.dart';
import 'package:provider/provider.dart';
import './providers/auth_service.dart';
import './providers/shipping_provider.dart';
import './providers/orders_provider.dart';
import './screens/login_screen.dart';
import './screens/home_screen.dart';
import './screens/admin_screen.dart';
import './screens/orders_screen.dart';
import './screens/create_order_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ShippingProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/admin_orders': (context) => AdminOrdersScreen(), // Маршрут для отображения заказов администратора
    
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/admin': (context) => AdminScreen(),
        '/orders': (context) => OrdersScreen(), // Добавление маршрута для OrdersScreen
        '/create_order': (context) => CreateOrderScreen(), // Маршрут для создания заказа
      },
    );
  }
}
