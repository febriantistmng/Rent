// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    this.idBooking,
    this.rate,
    this.review,
  });

  int idBooking;
  int rate;
  String review;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        idBooking: json["id_booking"],
        rate: json["rate"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id_booking": idBooking,
        "rate": rate,
        "review": review,
      };
}
