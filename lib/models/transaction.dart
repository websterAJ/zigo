class Transaction {
  final String id;
  final String type; // 'sale' or 'payment'
  final double amount;
  final DateTime date;
  final String description;
  final String? paymentMethod;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
    this.paymentMethod,
  });
}
