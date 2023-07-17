// class Brand {
//   int id;
//   String name;
//   Brand(this.id, this.name);

//   factory Brand.fromJson(Map<String, dynamic> json) {
//     return Brand(int.parse(json["id"].toString()), json["name"]);
//   }
// }

class Brand {
  final String name;
  final int? id;
  late final String image;

  Brand(this.id, this.name, this.image);

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(int.parse(json["id"].toString()), json["name"],json["image"]);
  }
}
