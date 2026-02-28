class Expense {
  final int? id;
  final double amount;
  final String type; // "Expense" or "Income"
  final String category;
  final int timestamp; // epoch ms

  Expense({
    this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.timestamp,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'amount': amount,
        'type': type,
        'category': category,
        'timestamp': timestamp,
      };

  static Expense fromMap(Map<String, Object?> map) => Expense(
        id: map['id'] as int?,
        amount: (map['amount'] as num).toDouble(),
        type: map['type'] as String,
        category: map['category'] as String,
        timestamp: map['timestamp'] as int,
      );
}
