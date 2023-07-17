import '../models/image_bannar.dart';
import 'api_helper.dart';

class ImagebannerController {
  Future<List<ImageBannarModel>> getAll() async {
    try {
      List<ImageBannarModel> imagebannars = [];
      var response = await ApiHelper().getRequest("/imagebannars");

      response.forEach((v) {
        imagebannars.add(ImageBannarModel.fromJson(v));
      });

      return imagebannars;
    } catch (ex) {
      rethrow;
    }
  }
}