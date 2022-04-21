


import 'dart:io';

class Transaction {
  int ?id;
  var user;
  String ?amount;
  String ?surname;


  Transaction(
      {this.user,
        this.id,
        this.surname,
        this.amount,
      });

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      'id': id,
      "surname": surname,
      'amount': amount,
    };
  }

  factory Transaction.fromJson(jsonData) => Transaction(
    user: jsonData["user"],
    surname: jsonData["surname"],
    id: jsonData['id'],
    amount: jsonData['amount'],
  );

}





class TransactionVendor {
  final id;
  final user;
  final amount;
  final vendoramount;
  final useramount;
  final category;
  final vendor;
  final created;
  final weight;


  TransactionVendor(
      {this.category,
        this.id,
        this.amount,
        this.user,
        this.vendoramount,
        this.created,
        this.weight,
        this.useramount,
        this.vendor,
      });

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      'id': id,
      'amount': amount,
      'category': category,
      'vendoramount': vendoramount,
      'useramount': useramount,
      'vendor': vendor,
      'created': created,
      'weight':weight,
    };
  }

  factory TransactionVendor.fromJson(jsonData) => TransactionVendor(
    category: jsonData["category"],
    id: jsonData['id'],
    amount: jsonData['amount'],
      user: jsonData['user'],
      vendoramount: jsonData['vendoramount'],
      useramount: jsonData['useramount'],
    vendor: jsonData['vendor'],
    created: jsonData['created'],
      weight: jsonData['weight'],
  );

}
