import 'package:untitled12/models/brand.dart';

import 'api_helper.dart';

class BrandsController {
  Future<List<Brand>> getAll() async {
    try {
      List<Brand> brands = [];
      var response = await ApiHelper().getRequest("/brands");

      response.forEach((v) {
        brands.add(Brand.fromJson(v));
      });

      return brands;
    } catch (ex) {
      print('Error fetching brands: $ex');
      rethrow;
    }
  }
}