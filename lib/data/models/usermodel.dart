import 'dart:convert';

Usermodel userloginmodelFromJson(String str) =>
    Usermodel.fromJson(json.decode(str));

String userloginmodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.idUser,
    this.name,
    this.email,
    this.password,
  });

  int idUser;
  String name;
  String email;
  String password;

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        idUser: json["id_user"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "password": password,
      };
}
