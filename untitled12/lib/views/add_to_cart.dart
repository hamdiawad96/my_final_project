import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled12/controllers/product_provider.dart';

import 'view_cart_page.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvier>(
      builder: (context, productProvider, child) {
        int productCount = productProvider.selectedProducts.length;

        return productCount > 0
            ? InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ViewCart(),
              ),
            );
          },
          child: Container(
            width: 350,
            height: 60,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.red,
                      ),
                    ),
                    if (productCount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              productCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
                Text(
                  'View Cart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
            : Container();
      },
    );
  }
}