import 'package:untitled12/models/login.dart';
import 'package:untitled12/models/signup.dart';
import 'dart:convert';

import '../models/order.dart';
import '../models/user.dart';
import 'api_helper.dart';


class UserController {
  Future<Login> login(String email, String password) async {
    try {
      var result = await ApiHelper().postRequest("/users/login", {
        "email": email,
        "password": password,
      });
      return Login.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignupModel> create(
      String email,
      String username,
      String firstName,
      String lastName,
      String city,
      String country,
      String phone,
      String password,
      ) async {
    try {
      var result = await ApiHelper().postRequest("/users/", {
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "city": city,
        "country": country,
        "phone": phone,
      });
      return SignupModel.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> update(
      {required String email,
      required String password,
      required String username,
        required String city,
        required String country,
        required String firstName,
        required String lastName,
        required String phone,}) async {
    try {
      var result = await ApiHelper().putRequest("/users", {
        "email": email,
        "password": password,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "city": city,
        "country": country,
        "phone": phone,


      });
      return User.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      var result = await ApiHelper().getRequest("/users");
      return User.fromJson(result);
    } catch (e) {
      // Handle specific errors or perform error logging here if needed
      throw Exception("Failed to get user: $e");
    }
  }






























//   Future<bool> createUser(UserModel user) async {
//     try {
//       // ignore: unused_local_variable
//       dynamic jsonObject =
//       await ApiHelper().postRequest('users', user.toJson());

//       return true;
//     } catch (ex) {
//       // ignore: avoid_print
//       print(ex);
//       rethrow;
//     }
//   }

//   Future<bool> login(UserModel user) async {
//     try {
//       dynamic jsonObject =
//       await ApiHelper().postRequest('users/login', user.toJson());
//       String type = jsonObject["type"];
//       String token = jsonObject["token"];
//       var storage = const FlutterSecureStorage();
//       await storage.write(key: "token", value: "$type $token");
//       return true;
//     } catch (ex) {
//       // ignore: avoid_print
//       print(ex.toString());
//       return false;
//     }
//   }

//   Future<UserModel> getUser() async {
//     dynamic jsonObject = await ApiHelper().getRequest('users');
//     return UserModel.fromJson(jsonObject);
//   }

//   Future<UserModel> updateUser(UserModel user) async {
//     try {
//       var storage = const FlutterSecureStorage();
//       String? token = await storage.read(key: "token");
//       if (token == null) {
//         throw Exception("No token available");
//       }

//       dynamic jsonObject = await ApiHelper().putRequest(
//           'users/${user.id}}', user.toJson(),
//           headers: {'Authorization': token});

//       return UserModel.fromJson(jsonObject);
//     } catch (ex) {
//       // ignore: avoid_print
//       print(ex);
//       rethrow;
//     }
//     }
// }























// Future<User> signup({
//   required String email,
//   required String password,
//   required String username,
//   required String firstName,
//   required String lastName,
//   required String city,
//   required String country,
//   required String phone,
// }) async {
//   try {
//     final result = await ApiHelper().postRequest('/users', {
//       'email': email,
//       'password': password,
//       'username': username,
//       'first_name': firstName,
//       'last_name': lastName,
//       'address': {
//         'city': city,
//         'country': country,
//         'phone': phone,
//       },
//     });

//     return User.fromJson(result);
//   } catch (e) {
//     rethrow;
//   }
// }
}

// Future<String> uploadImage(File file) async {
//   try {
//     var result = await ApiHelper().uploadImage(file, "/api/storage");
//     print(result);
//     return result["path"];
//   } catch (ex) {
//     print(ex);
//     rethrow;
//   }
// }
