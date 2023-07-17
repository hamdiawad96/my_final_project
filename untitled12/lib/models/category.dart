class Category {
  late final int id;
  late final String name;
  late final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      // Return a default category if json is null
      return Category(id: 0, name: '', image: '');
    }

    return Category(
      id: int.parse(json["id"].toString()),
      name: json["name"],
      image: json["image"],
    );
  }

}
