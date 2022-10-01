import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    required this.id,
    required this.createdAt,
    required this.category,
    required this.type,
    required this.amount,
    required this.balance,
    required this.reference,
    required this.valueDate,
    required this.description,
  });

  final String id;
  final DateTime createdAt;
  final String category;
  final String type;
  final double amount;
  final dynamic balance;
  final String reference;
  final DateTime valueDate;
  final String description;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"] ?? 'Sin categoría',
        type: json["type"],
        amount: double.tryParse(json["amount"].toString()) ?? 0,
        balance: json["account"]["balance"]["available"],
        reference: json["reference"],
        valueDate: DateTime.parse(json["value_date"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "type": type,
        "amount": amount,
        "balance": balance,
        "reference": reference,
        "value_date":
            "${valueDate.year.toString().padLeft(4, '0')}-${valueDate.month.toString().padLeft(2, '0')}-${valueDate.day.toString().padLeft(2, '0')}",
        "description": description,
      };
}
