// To parse this JSON data, do
//
//     final singUpModel = singUpModelFromJson(jsonString);

import 'dart:convert';

SingUpModel singUpModelFromJson(String str) =>
    SingUpModel.fromJson(json.decode(str));

String singUpModelToJson(SingUpModel data) => json.encode(data.toJson());

class SingUpModel {
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? country;
  String? city;
  String? state;
  String? zipCode;
  String? address;
  String? addressLine1;
  String? lengthOfTerm;
  String? sizeOfHome;
  String? message;

  SingUpModel({
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.country,
    this.city,
    this.state,
    this.zipCode,
    this.address,
    this.addressLine1,
    this.lengthOfTerm,
    this.sizeOfHome,
    this.message,
  });

  factory SingUpModel.fromJson(Map<String, dynamic> json) => SingUpModel(
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        phone: json["phone"],
        country: json["country"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        address: json["address"],
        addressLine1: json["address_line_1"],
        lengthOfTerm: json["length_of_term"],
        sizeOfHome: json["size_of_home"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "country": country,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "address": address,
        "address_line_1": addressLine1,
        "length_of_term": lengthOfTerm,
        "size_of_home": sizeOfHome,
        "message": message,
      };
}
