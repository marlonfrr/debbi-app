import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String id;
  final String link;
  final String name;
  final String number;
  final String category;
  final String currency;
  final String type;
  final Balance balance;

  Product({
    required this.id,
    required this.link,
    required this.name,
    required this.number,
    required this.category,
    required this.currency,
    required this.type,
    required this.balance,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        link: json["link"],
        name: json["name"],
        number: json["number"],
        category: json["category"],
        currency: json["currency"],
        type: json["type"],
        balance: Balance.fromJson(json["balance"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "number": number,
        "category": category,
        "currency": currency,
        "type": type,
        "balance": balance.toJson(),
      };
}

class Balance {
  Balance({
    required this.current,
    required this.available,
  });

  final double current;
  final double available;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        current: double.tryParse(json["current"].toString()) ?? 0,
        available: double.tryParse(json["available"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "available": available,
      };
}
