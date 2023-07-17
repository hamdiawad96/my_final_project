import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:untitled12/controllers/location_controller.dart';
import 'package:untitled12/controllers/product_provider.dart';
import 'package:untitled12/models/product.dart';
import 'package:untitled12/views/custom/summery_widget.dart';
import 'package:untitled12/views/loginPage.dart';
import 'package:untitled12/views/order_checkout_page.dart';
class ViewCart extends StatelessWidget {
  const ViewCart({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Consumer(
        builder: (context, ProductProvier productProvier, child) {
          if (productProvier.selectedProducts.isEmpty) {
            return Center(child: Text("Your cart is empty"));
          }
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: _productsListWidget(productProvier),
              ),
              SummeryWidget(),
              _buttonCheckoutWidget(context),
            ],
          );
        },
      ),
    );
  }

  SizedBox _buttonCheckoutWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            _handleBeginCheckoutAction(context);
          },
          child: Text("Begin Checkout"),
        ),
      ),
    );
  }



  ListView _productsListWidget(ProductProvier productProvier) {
    return ListView.builder(
      itemCount: productProvier.selectedProducts.length,
      itemBuilder: (context, index) {
        Product product = productProvier.selectedProducts[index];
        return Dismissible(
          key: Key(index.toString()),
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          onDismissed: (direction) {
            productProvier.removeProduct(index);
          },
          child: Expanded(
            child: Card(
              child: ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Flexible(
                  child: Text(
                    product.productTitle,
                  ),
                ),
                subtitle: Text("Total: ${product.total.toStringAsFixed(2)}"),
                trailing: Container(
                  width: 155,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end, // Aligns buttons to the right
                            children: [
                              TextButton(
                                onPressed: () {
                                  try {
                                    productProvier.updateQty(
                                      product,
                                      product.selectedQty + 1,
                                    );
                                  } catch (ex) {
                                    print(ex);
                                  }
                                },
                                child: Text("+"),
                              ),
                              SizedBox(
                                width: 20,
                                child: Text(
                                  "${product.selectedQty}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (product.selectedQty == 1) {
                            productProvier.removeProduct(index);
                            return;
                          }
                          productProvier.updateQty(
                            product,
                            product.selectedQty - 1,
                          );
                        },
                        child: product.selectedQty == 1 ? Icon(Icons.delete) : Text("-"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  _handleBeginCheckoutAction(BuildContext context) async {
    bool exists = await FlutterSecureStorage().containsKey(key: "token");

    if (exists) {
      _handleGoToOrderCheckout(context);
    } else {
      var result = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));

      if (result != null) {
        _handleGoToOrderCheckout(context);
      }
    }
  }

  _handleGoToOrderCheckout(BuildContext context) async {
    try {
      EasyLoading.show(status: "Fetching location");
      Position location = await LocationController().determinePosition();
      EasyLoading.dismiss();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OrderCheckoutPage(location)));
    } catch (ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    }
  }
}
