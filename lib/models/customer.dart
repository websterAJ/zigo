import 'transaction.dart';

class Customer {
  final String id;
  final String name;
  final String? businessName;
  final String phone;
  final String address;
  final String? category;
  final double creditLimit;
  final String? profilePic;
  final List<Transaction> transactions;
  final String? taxId;

  Customer({
    required this.id,
    required this.name,
    this.businessName,
    required this.phone,
    required this.address,
    this.category,
    this.creditLimit = 0.0,
    this.profilePic,
    this.transactions = const [],
    this.taxId,
  });

  double get totalDebt {
    double debt = 0;
    for (var t in transactions) {
      if (t.type == 'sale') {
        debt += t.amount;
      } else {
        debt -= t.amount;
      }
    }
    return debt;
  }

  String get overdueStatus {
    if (totalDebt <= 0) return 'AL DÍA';
    // Mocking logic for example
    final oldestUnpaid = transactions.where((t) => t.type == 'sale').toList();
    if (oldestUnpaid.isEmpty) return 'AL DÍA';
    final diff = DateTime.now().difference(oldestUnpaid.first.date).inDays;
    if (diff > 30) return 'VENCIDO HACE ${diff - 30} DÍAS';
    if (diff > 15) return 'POR VENCER';
    return 'DENTRO DEL PLAZO';
  }
}
