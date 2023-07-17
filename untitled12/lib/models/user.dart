// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   String? id;
//   String username;
//   String email;
//   String password;

//   UserModel({
//     this.id,
//     required this.username,
//     required this.email,
//     required this.password,
//   });

//   Map<String, dynamic> toJson() => {
//     "user_name": username,
//     "password": password,
//     "email": email,
//   };

import 'package:untitled12/models/address.dart';

// User UserFromJson(String str) => User.fromJson(json.decode(str));

// String UserToJson(User data) => json.encode(data.toJsonCreate());

class User {
  String firstName;
  String lastName;
  String city;
  String country;
  String phone;
  String username;
  String email;
  String password;
  // final Address address;

  User( {
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.country,
    required this.phone,
    required this.username,
    required this.email,
    required this.password,
    // required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName:json['first_name'],
   lastName :json['last_name'],
    city:json['city'],
    country:json['country'],
    phone:json['phone'],
    username:json['username'],
    email:json['email'],
    password:json['password'],
        // address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJsonCreate() => {
        "email": email,
        "password": password,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        // "address": address.toJsonCreate(),
      };
}

// User AddressFromJson(String str) => User.fromJson(json.decode(str));

// String AddressToJson(User data) => json.encode(data.toJsonCreate());

// class Address {
//   final String city;
//   final String country;
//   final String phone;

//   Address({
//     required this.city,
//     required this.country,
//     required this.phone,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         city: json["city"],
//         country: json["country"],
//         phone: json["phone"],
//       );

//   Map<String, dynamic> toJsonCreate() => {
//         "city": city,
//         "country": country,
//         "phone": phone,
//       };
// }


// class User {
//   String email;
//   String? password;
//   String username;
//   String? firstName;
//   String? lastName;
//   Address? address;

//   User({
//     required this.email,
//     required this.password,
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     required this.address,
//   });
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json["email"],
//       password: json["password"],
//       username: json["username"],
//       firstName: json["first_name"],
//       lastName: json["last_name"],
//       address: Address.fromJson(json["address"]),
//     );
//   }
// }

// //   Map<String, dynamic> toJson() => {
// //         "email": email,
// //         "password": password,
// //         "username": username,
// //         "first_name": firstName,
// //         "last_name": lastName,
// //         "address": address.toJson(),
// //       };
// // }

// class Address {
//   final String city;
//   final String country;
//   final String phone;

//   Address({
//     required this.city,
//     required this.country,
//     required this.phone,
//   });
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       city: json["city"],
//       country: json["country"],
//       phone: json["phone"],
//     );
//   }
// }

//   factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         city: json["city"],
//         country: json["country"],
//         phone: json["phone"],
//       );

//   Map<String, dynamic> toJson() => {
//         "city": city,
//         "country": country,
//         "phone": phone,
//       };
// }
