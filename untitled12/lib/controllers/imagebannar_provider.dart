import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/image_bannar.dart';
// class MainScreenProvider extends ChangeNotifier {
//
//   List<ImageBannarModel> bannerImageList = [];
//
//
//   void getImageBanner() async {
//     final response = await http
//         .get(Uri.parse("https://alshalbiapps.com/API/getbannerimages.php"));
//     if (response.statusCode == 200) {
//       var jsonBody = jsonDecode(response.body);
//       var img = jsonBody['Images'];
//       for (Map i in img) {
//         bannerImageList.add(ImageBannarModel(i['Id'], i['ImageURL']));
//       }
//       notifyListeners();
//     }
//   }
// }