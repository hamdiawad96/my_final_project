import 'dart:convert';

import 'package:untitled12/controllers/api_helper.dart';
import 'package:untitled12/models/product.dart';

import '../models/category.dart';
class ProductController {
  Future<List<Product>> getAll() async {
    try {
      List<Product> products = [];
      var response = await ApiHelper().getRequest("/products");

      response.forEach((v) {
        products.add(Product.fromJson(v));
      });

      return products;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<Product>> fetchProductsByCategoryId(int categoryId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest2(
          "/products/$categoryId", categoryId);

      if (jsonObject != null && jsonObject is List) {
        List<Product> products = [];

        jsonObject.forEach((v) {
          if (v is Map<String, dynamic>) {
            products.add(Product.fromJson(v));
          }
        });

        return products;
      } else {
        throw ApiException('Invalid response');
      }
    } catch (ex) {
      rethrow;
    }
  }
}