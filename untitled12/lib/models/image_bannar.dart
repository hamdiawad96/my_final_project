class ImageBannarModel{
  late final String image;
  late final int? id;
  ImageBannarModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json["id"].toString());
    image = json["image"];


  }

}