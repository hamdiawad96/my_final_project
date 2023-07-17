import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

import '../controllers/order_controller.dart';
import '../controllers/product_provider.dart';
import '../models/address.dart';
import '../models/order.dart';
import 'HomePage.dart';
import 'custom/summery_widget.dart';







class OrderCheckoutPage extends StatefulWidget {
  Position location;
  OrderCheckoutPage(this.location, {super.key});

  @override
  State<OrderCheckoutPage> createState() => _OrderCheckoutPageState();
}

class _OrderCheckoutPageState extends State<OrderCheckoutPage> {
  int activeStep = 0;
  int upperBound = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconStepper(
              icons: [
                Icon(Icons.location_on_rounded),
                Icon(Icons.location_on_rounded),
                Icon(Icons.payment_rounded),
                Icon(Icons.summarize),
              ],
              enableNextPreviousButtons: false,
              lineLength: 35,
              activeStep: activeStep,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
              activeStepColor: Colors.blue, // Customize the active step color
              activeStepBorderColor: Colors.blue, // Customize the active step border color
            ),
            Expanded(
                child: IndexedStack(
              index: activeStep,
              children: [
                GoogleMapStep(widget.location),
                AddressFormStep(),
                PaymentMethodStep(),
                SummaryStep(),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        var productProvider =
        Provider.of<ProductProvier>(context, listen: false);
        switch (activeStep) {
          case 0:
            setState(() {
              activeStep++;
            });
            break;
          case 1:
            if (productProvider.keyForm.currentState!.validate()) {
              setState(() {
                activeStep++;
              });
            }
            break;
          case 2:
            setState(() {
              activeStep++;
            });
            break;
          case 3:
            OrderController()
                .create(Order(
                products: productProvider.selectedProducts,
                address: productProvider.address!,
                paymentMethodId: productProvider.paymentMethod,
                total: productProvider.total,
                taxAmount: productProvider.taxAmount,
                subTotal: productProvider.subTotal))
                .then((value) {
              EasyLoading.dismiss();

              EasyLoading.showSuccess("Done yr order sent ");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }).catchError((ex) {
              EasyLoading.dismiss();
              EasyLoading.showError(ex.toString());
            });
            break;
        }
      },
      child: Text('Next'),
    );
  }



  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      default:
        return 'Introduction';
    }
  }
}

class GoogleMapStep extends StatefulWidget {
  Position location;

  GoogleMapStep(this.location, {super.key});

  @override
  State<GoogleMapStep> createState() => _GoogleMapStepState();
}

class _GoogleMapStepState extends State<GoogleMapStep> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _initalPostion;
  late LatLng _requiredLocation;

  @override
  void initState() {
    super.initState();

    _initalPostion = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 16,
    );
    _requiredLocation =
        LatLng(widget.location.latitude, widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return mapWidget();
  }

  Widget mapWidget() {
    double mapWidth = MediaQuery.of(context).size.width;
    double mapHeight = MediaQuery.of(context).size.height - 215;
    return Stack(alignment: Alignment(0.0, 0.0), children: <Widget>[
      Container(
          width: mapWidth,
          height: mapHeight,
          child: GoogleMap(
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            initialCameraPosition: _initalPostion,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition position) {
              _requiredLocation = position.target;
            },
            onCameraIdle: () {
              _getAddressFromLatLng();
            },
          )),
      Positioned(
        top: (mapHeight - 50) / 2,
        right: (mapWidth - 50) / 2,
        child: Icon(
          Icons.location_on,
          size: 50,
          color: Colors.red,
        ),
      ),
    ]);
  }

  Future<void> _getAddressFromLatLng() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _requiredLocation.latitude, _requiredLocation.longitude);

    Placemark first = placemarks.first;
    print("${first.country}:${first.street}");

    Address address = Address();
    address.latitude = _requiredLocation.latitude;
    address.longitude = _requiredLocation.longitude;
    address.country = first.country!;
    address.city = first.locality!;
    address.area = first.subLocality!;
    address.street = first.street!;
    address.buildingNo = "";

    var productProvider = Provider.of<ProductProvier>(context, listen: false);
    productProvider.updateAddress(address);
  }
}

class AddressFormStep extends StatelessWidget {
  AddressFormStep({Key? key}) : super(key: key);
  final _controllerCountry = TextEditingController();
  final _controllerCity = TextEditingController();
  final _controllerArea = TextEditingController();
  final _controllerStreet = TextEditingController();
  final _controllerBuilding = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvier>(builder: (context, productProvider, child) {
      return formWidget(productProvider, context);
    });
  }

  Widget formWidget(ProductProvier productProvider, BuildContext context) {
    _controllerCountry.text = productProvider.address!.country;
    _controllerCity.text = productProvider.address!.city;
    _controllerArea.text = productProvider.address!.area;
    _controllerStreet.text = productProvider.address!.street;
    _controllerBuilding.text = productProvider.address!.buildingNo;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/736x/5b/ad/6c/5bad6c563f2da24a1f7ce2ef67517e2c.jpg'), // Replace with your actual image URL
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: productProvider.keyForm,
            child: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _controllerCountry,
                    enabled: false, // Make the field uneditable
                    style: TextStyle(
                      color: Colors.black, // Set the text color to gray
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey,
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.black, // Set the color of the suffix icon to gray
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _controllerCity,
                    enabled: false, // Make the field uneditable
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey,
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.black, // Set the color of the suffix icon to gray
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _controllerArea,
                    decoration: InputDecoration(
                      hintText: 'Area',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _controllerStreet,
                    enabled: false, // Make the field uneditable
                    style: TextStyle(
                      color: Colors.black, // Set the text color to gray
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey,
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.black, // Set the color of the suffix icon to gray
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _controllerBuilding,
                    decoration: InputDecoration(
                      hintText: 'Building No.',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvier>(builder: (context, productProvider, child) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/736x/5b/ad/6c/5bad6c563f2da24a1f7ce2ef67517e2c.jpg',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Card(
                  child: ListTile(
                    onTap: () {
                      productProvider.updatePaymentMethod(1);
                    },
                    leading: Icon(
                      Icons.attach_money_outlined,
                      color: Colors.green,
                    ),
                    title: Text("Cash On Delivery"),
                    trailing: Radio<int>(
                      value: 1,
                      groupValue: productProvider.paymentMethod,
                      onChanged: (value) {
                        productProvider.updatePaymentMethod(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  child: ListTile(
                    onTap: () {
                      productProvider.updatePaymentMethod(2);
                    },
                    leading: Icon(
                      Icons.payment,
                      color: Colors.green,
                    ),
                    title: Text("Debit Card"),
                    trailing: Radio<int>(
                      value: 2,
                      groupValue: productProvider.paymentMethod,
                      onChanged: (value) {
                        productProvider.updatePaymentMethod(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SummaryStep extends StatelessWidget {
  const SummaryStep({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ProductProvier productProvider, child) {
      return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                '',
                //https://i.pinimg.com/736x/5b/ad/6c/5bad6c563f2da24a1f7ce2ef67517e2c.jpg
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _addressWidget(productProvider),
              const SizedBox(height: 20),
              SummeryWidget(),
            ],
          ),
        ),
      );
    });
  }

  Widget _addressWidget(ProductProvier productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery Address",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3),
        const Divider(),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Country",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              productProvider.address?.country ?? "Unknown Country",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 3),
        const Divider(),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "City",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              productProvider.address?.city ?? "Unknown city",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 3),
        const Divider(),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Area",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              productProvider.address!.area,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 3),
        const Divider(),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Street",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              productProvider.address!.street,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 3),
        const Divider(),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Building No.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              productProvider.address!.buildingNo,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
