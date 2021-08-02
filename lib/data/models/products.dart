// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:rent/data/service/network_service.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.brand,
    this.details,
    this.idProducts,
    this.image,
    this.spec,
    this.location,
    this.name,
    this.price,
    this.rentalType,
    this.type,
  });

  String brand;
  String details;
  int idProducts;

  List<String> image;
  String location;
  String name;
  int price;
  RentalType rentalType;
  ProductType type;
  Spec spec;
  String get rentalTypeStr => getTypeStr(rentalType);
  String get productTypeStr => getProductTypeStr(type);
  String get rentalTypeStrRead => rentalType == RentalType.daily
      ? "/day"
      : "/${rentalTypeStr.replaceAll("ly", "")}";
  String get priceTypeStr => rentalType == RentalType.daily
      ? "$price/day"
      : "$price/${rentalTypeStr.replaceAll("ly", "")}";
  List<String> get imageUrls =>
      image.map((e) => NetworkService.BASEURL + "/product/image/" + e).toList();
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        brand: json["brand"],
        details: json["details"],
        idProducts: json["id_products"],
        image: json["image"].toString().split(";")
          ..removeWhere((element) => element.isEmpty)
          ..toList(),
        location: json["location"],
        name: json["name"],
        price: json["price"],
        rentalType: getType(json["rental_type"]),
        type: getProductType(json["type"]),
        spec: json["spec"] != null ? Spec.fromJson(json["spec"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "details": details,
        "id_products": idProducts,
        "image": image.join(";"),
        "location": location,
        "name": name,
        "price": price,
        "rental_type": getTypeStr(rentalType),
        "spec": spec.toJson(),
        "type": getProductTypeStr(type),
      };
}

class Spec {
  Spec({
    this.color,
    this.gearBox,
    this.motor,
    this.seat,
    this.speed0100,
    this.topSpeed,
  });

  String color;
  String gearBox;
  String motor;
  int seat;
  String speed0100;
  String topSpeed;

  factory Spec.fromJson(Map<String, dynamic> json) => Spec(
        color: json["Color"],
        gearBox: json["Gear Box"],
        motor: json["Motor"],
        seat: json["Seat"],
        speed0100: json["Speed(0-100)"],
        topSpeed: json["Top Speed"],
      );

  Map<String, dynamic> toJson() => {
        "Color": color,
        "Gear Box": gearBox,
        "Motor": motor,
        "Seat": seat,
        "Speed(0-100)": speed0100,
        "Top Speed": topSpeed,
      };
}

RentalType getType(String typeStr) {
  return RentalType.values.firstWhere((e) => getTypeStr(e) == typeStr);
}

String getTypeStr(RentalType type) {
  return type.toString().split(".").last;
}

ProductType getProductType(String typeStr) {
  return ProductType.values.firstWhere((e) => getProductTypeStr(e) == typeStr);
}

String getProductTypeStr(ProductType type) {
  return type.toString().split(".").last;
}

enum ProductType { car, bike }
enum RentalType { monthly, weekly, daily }
