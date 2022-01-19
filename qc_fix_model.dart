import 'dart:convert';

class QCCheckFixModel {
  final String fix;
  final String amount;
  final String qty;
  QCCheckFixModel({
    required this.fix,
    required this.amount,
    required this.qty,
  });

  QCCheckFixModel copyWith({
    String? fix,
    String? amount,
    String? qty,
  }) {
    return QCCheckFixModel(
      fix: fix ?? this.fix,
      amount: amount ?? this.amount,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fix': fix,
      'amount': amount,
      'qty': qty,
    };
  }

  factory QCCheckFixModel.fromMap(Map<String, dynamic> map) {
    return QCCheckFixModel(
      fix: map['fix'] ?? '',
      amount: map['amount'] ?? '',
      qty: map['qty'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QCCheckFixModel.fromJson(String source) => QCCheckFixModel.fromMap(json.decode(source));

  @override
  String toString() => 'QCCheckFixModel(fix: $fix, amount: $amount, qty: $qty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is QCCheckFixModel &&
      other.fix == fix &&
      other.amount == amount &&
      other.qty == qty;
  }

  @override
  int get hashCode => fix.hashCode ^ amount.hashCode ^ qty.hashCode;
}
