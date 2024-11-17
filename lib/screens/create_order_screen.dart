import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _itemTypeController = TextEditingController();
  final _containerNumberController = TextEditingController();
  final _itemIdController = TextEditingController();
  final _requiredQuantityController = TextEditingController();

  @override
  void dispose() {
    _itemTypeController.dispose();
    _containerNumberController.dispose();
    _itemIdController.dispose();
    _requiredQuantityController.dispose();
    super.dispose();
  }

  void _createOrder() {
    if (_itemTypeController.text.isEmpty ||
        _containerNumberController.text.isEmpty ||
        _itemIdController.text.isEmpty ||
        _requiredQuantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill out all fields.'),
          backgroundColor: kErrorColor,
        ),
      );
      return;
    }

    // Создание уникального ID заявки
    final String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

    final newOrder = Order(
      id: uniqueId,
      itemType: _itemTypeController.text,
      containerNumber: _containerNumberController.text,
      itemId: _itemIdController.text,
      requiredQuantity: int.parse(_requiredQuantityController.text),
    );

    Provider.of<OrdersProvider>(context, listen: false).addOrder(newOrder);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order created successfully!'),
        backgroundColor: kPrimaryColor,
      ),
    );

    Navigator.pop(context);
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Order'),
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(_itemTypeController, 'Item Type'),
            SizedBox(height: kDefaultPadding),
            _buildTextField(_containerNumberController, 'Container Number'),
            SizedBox(height: kDefaultPadding),
            _buildTextField(_itemIdController, 'Item ID'),
            SizedBox(height: kDefaultPadding),
            _buildTextField(_requiredQuantityController, 'Required Quantity', isNumeric: true),
            SizedBox(height: kDefaultPadding * 2),
            ElevatedButton(
              onPressed: _createOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Create Order',
                style: TextStyle(color: kButtonTextColor, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
