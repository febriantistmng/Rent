// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

import 'package:rent/data/models/products.dart';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    this.date,
    this.idBooking,
    this.idProduct,
    this.idUser,
    this.notes,
    this.product,
    this.paymentType,
    this.rentEnd,
    this.rentStart,
    this.totalFee,
  });

  DateTime date;
  int idBooking;
  int idProduct;
  int idUser;
  String notes;
  PaymentType paymentType;
  Product product;
  DateTime rentEnd;
  DateTime rentStart;
  int reviewed;
  String totalFee;
  String get paymentTypeStr => getTypeStr(paymentType);
  factory Book.fromJson(Map<String, dynamic> json) => Book(
        date: DateTime.parse(json["date"]),
        idBooking: json["id_booking"],
        idProduct: json["id_product"],
        idUser: json["id_user"],
        notes: json["notes"],
        paymentType: getType(json["payment_type"]),
        rentEnd: DateTime.parse(json["rent_end"]),
        rentStart: DateTime.parse(json["rent_start"]),
        totalFee: json["total_fee"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "id_booking": idBooking,
        "id_product": idProduct,
        "id_user": idUser,
        // "product": product.toJson(),
        "notes": notes,
        "payment_type": getTypeStr(paymentType),
        "rent_end":
            "${rentEnd.year.toString().padLeft(4, '0')}-${rentEnd.month.toString().padLeft(2, '0')}-${rentEnd.day.toString().padLeft(2, '0')}",
        "rent_start":
            "${rentStart.year.toString().padLeft(4, '0')}-${rentStart.month.toString().padLeft(2, '0')}-${rentStart.day.toString().padLeft(2, '0')}",
        "total_fee": totalFee,
      };
}

PaymentType getType(String typeStr) {
  return PaymentType.values.firstWhere((e) => getTypeStr(e) == typeStr);
}

String getTypeStr(PaymentType type) {
  return type.toString().split(".").last;
}

enum PaymentType { DANA, OVO, SPAY, MBANKING }
