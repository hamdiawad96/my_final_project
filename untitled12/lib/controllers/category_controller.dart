import '../models/category.dart';
import 'api_helper.dart';

class CategoryController {
  Future<List<Category>> getAll() async {
    try {
      List<Category> categories = [];
      var response = await ApiHelper().getRequest("/categories");

      response.forEach((v) {
        categories.add(Category.fromJson(v));
      });

      return categories;
    } catch (ex) {
      print('Error fetching categories: $ex');
      rethrow;
    }
  }
}