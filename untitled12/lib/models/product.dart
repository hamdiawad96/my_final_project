import 'brand.dart';
import 'category.dart';
class Product {
  late final String productTitle;
  late final int? id;
  late final int categoryId;
  late final String image;
  late double price;
  late int? currentQty;
  late final String description;
  late final Category category;
  late double tax = 16;
  int selectedQty = 0;


  Product({
    required this.id,
    required this.productTitle,
    required this.categoryId,
    required this.image,
    required this.price,
    required this.currentQty,
    required this.description,
    required this.category,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"] as int?;
    productTitle = json["product_title"] ?? '';
    categoryId = json["category_id"] as int? ?? 0;
    image = json["image"] ?? '';
    try {
      price = double.parse(json["price"].toString());
    } catch (e) {
      price = 0.0; // Assign a default value if parsing fails
    }
    currentQty = json["current_qty"] as int? ?? 0;
    description = json["description"] ?? ''; // Handle missing or null values
    final categoryData = json["category"];
    if (categoryData != null) {
      category = Category.fromJson(categoryData);
    } else {
      category = Category(id: 0, name: '', image: ''); // Assign a default category if it's null
    }
// Handle null category

  }


  double get finalPrice {
    return price * (1 + (tax / 100));
  }

  double get subTotal {
    return price * selectedQty;
  }

  double get taxAmount {
    return (price * (tax / 100)) * selectedQty;
  }

  double get total {
    return (price * (1 + (tax / 100))) * selectedQty;
  }

  double get total2 => price * selectedQty;

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": id,
    "qty": selectedQty,
    "price": price,
    "total": total,
  };
}
