class Order {
  final String id;
  final String itemType;
  final String containerNumber;
  final String itemId;
  final int requiredQuantity;
  String status; // "Создан", "В работе", "Отправлен"

  Order({
    required this.id,
    required this.itemType,
    required this.containerNumber,
    required this.itemId,
    required this.requiredQuantity,
    this.status = 'Создан',
  });
}
