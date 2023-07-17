import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() {
    return 'ApiException: $message';
  }
}

class ApiHelper {
  final String DOMAIN = "127.0.0.1:3333";
      // "104.248.39.115:3333";
  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    bool check = await storage.containsKey(key: "token");
    if (check) {
      String result = await storage.read(key: "token") as String;
      return result;
    }
    return "";
  }

  Future<dynamic> getRequest(String path) async {
    Uri uriFunction = Uri.http(DOMAIN, path);
    var token = await getToken();
    var headers = {"Authorization": token};
    http.Response response = await http.get(uriFunction, headers: headers);
    return responseFunction(response);
  }

  Future<dynamic> getRequest2(String path, int categoryId) async {
    try {
      Uri uriFunction = Uri.http(DOMAIN, path);
      var token = await getToken();
      var headers = {"Authorization": token,
        "categoryId": categoryId.toString()
      };
      http.Response response = await http.get(uriFunction.replace(
          queryParameters: {'categoryId': categoryId.toString()}),
          headers: headers);

      print(response.body); // Print the response body to examine its contents

      return responseFunction(response);
    } catch
    (ex) {
      print(ex);
      return (ex);
    }
  }



  Future<dynamic> postRequest(String path, Map<String, dynamic> body) async {
    Uri uri = Uri.http(DOMAIN, path);

    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Request successful, parse the response JSON
      return jsonDecode(response.body);
    } else {
      // Request failed, throw an ApiException with the error message
      throw ApiException("Server Error");
    }
  }

  Future<dynamic> putRequest(String path, Map<String, dynamic> body) async {
    Uri uriFunction = Uri.http(DOMAIN, path);
    var token = await getToken();
    var headers = {"Authorization": token};
    http.Response response =
    await http.put(uriFunction, body: body, headers: headers);
    return responseFunction(response);
  }

  dynamic responseFunction(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw ApiException("Bad Request");
      case 401:
        throw ApiException("Unauthorized");
      case 402:
        throw ApiException("Payment Required");
      case 403:
        throw ApiException("Forbidden");
      case 404:
        throw ApiException("Not Found");
      case 500:
        throw ApiException("Server Error :(");
      default:
        throw ApiException("Server Error :(");
    }
  }

  Future postDio(String path, Map<String, dynamic> body) async {
    final dio = Dio();

    var token = await getToken();
    var headers = {"Authorization": token};

    Response response = await dio.post(
      'http://$DOMAIN$path',
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ApiException("Bad Request");
      case 401:
        throw ApiException("Unauthorized");
      case 402:
        throw ApiException("Payment Required");
      case 403:
        throw ApiException("Forbidden");
      case 404:
        throw ApiException("Not Found");
      case 500:
        throw ApiException("Server Error :(");
      default:
        throw ApiException("Server Error :(");
    }
  }

  Future uploadImage(File file, urlPath) async {
    final dio = Dio();

    var token = await getToken();
    var headers = {"Authorization": token};

    FormData formData = FormData.fromMap({
      "image_file": await MultipartFile.fromFile(file.path,
          filename: file.path.split("/").last)
    });
    Response response = await dio.post(
      'http://$DOMAIN$urlPath',
      data: formData,
      options: Options(
        headers: headers,
      ),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ApiException("Bad Request");
      case 401:
        throw ApiException("Unauthorized");
      case 402:
        throw ApiException("Payment Required");
      case 403:
        throw ApiException("Forbidden");
      case 404:
        throw ApiException("Not Found");
      case 500:
        throw ApiException("Server Error :(");
      default:
        throw ApiException("Server Error :(");
    }
  }
}