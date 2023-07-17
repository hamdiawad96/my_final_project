import 'package:untitled12/controllers/api_helper.dart';
import 'package:untitled12/models/order.dart';

class OrderController {
  Future<dynamic> create(Order order) async {
    try {
      var result = await ApiHelper().postDio("/orders", order.toJson());
      print(result);
      return result;

    } catch (e) {
      rethrow;
    }
  }
}
