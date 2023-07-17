import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/api_helper.dart';
import '../controllers/product_controller.dart';
import '../controllers/product_provider.dart';
import '../models/category.dart';
import '../models/product.dart';
import 'add_to_cart.dart';

class CategoryProductsPage extends StatefulWidget {
  final Category category;

  const CategoryProductsPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  List<Product> products = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProductsByCategoryId(widget.category.id);
  }

  Future<void> fetchProductsByCategoryId(int categoryId) async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Product> fetchedProducts =
          await ProductController().fetchProductsByCategoryId(categoryId);
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } on ApiException catch (error) {
      setState(() {
        errorMessage = getErrorDescription(error);
        isLoading = false;
      });
      // print('Error fetching products: $error');
    } on SocketException catch (error) {
      setState(() {
        errorMessage =
            'Network error occurred. Please check your internet connection.';
        isLoading = false;
      });
      print('Network error occurred: $error');
    } catch (error) {
      setState(() {
        errorMessage = 'An error occurred.';
        isLoading = false;
      });
      print('Error fetching products: $error');
    }
  }

  String getErrorDescription(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else {
      return 'An error occurred.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(errorMessage),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: products.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            Product product = products[index];

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    _handleViewProduct(product);
                                  },
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: Image.network(
                                    product.image,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(product.productTitle),
                                  subtitle: Text(product.category.name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Price:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize:
                                              12, // Adjust the font size as desired
                                        ),
                                      ),
                                      Text(
                                        product.finalPrice.toStringAsFixed(2),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize:
                                              12, // Adjust the font size as desired
                                        ),
                                      ),
                                      Text(
                                        ' JD',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize:
                                              12, // Adjust the font size as desired
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AddToCartWidget(),
                      ),
                    ],
                  ),
      ),
    );
  }

  void _handleViewProduct(Product product) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      product.productTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.category.name,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "About this product:",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              product.selectedQty++;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          "${product.selectedQty}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 30),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (product.selectedQty > 0) {
                                product.selectedQty--;
                              }
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      child: const Text('Add to cart'),
                      onPressed: () {
                        var productProvider =
                            Provider.of<ProductProvier>(context, listen: false);
                        productProvider.addToCart(product);
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(height: 30),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
// Future<void> fetchBrands() async {
//   try {
//     final List<Brand> fetchedBrands = await BrandsController().getAll();
//     setState(() {
//       brands = fetchedBrands;
//     });
//   } catch (error) {
//     print('Error fetching brands: $error');
//   }
// }








// Container(
//   padding: EdgeInsets.only(bottom: 20),
//   child: SizedBox(
//     height: 100,
//     child: ListView.separated(
//       scrollDirection: Axis.horizontal,
//       itemCount: brands.length,
//       separatorBuilder: (context, index) => SizedBox(width: 20),
//       itemBuilder: (context, index) {
//         Brand brand = brands[index];
//         return GestureDetector(
//           onTap: () {
//             // Handle brand tap if needed
//           },
//           child: Column(
//             children: [
//               ClipOval(
//                 child: Image.network(
//                   brand.image,
//                   width: 50,
//                   height: 50,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Text(brand.name),
//             ],
//           ),
//         );
//       },
//     ),
//   ),
// ),