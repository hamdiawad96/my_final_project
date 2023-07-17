import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:untitled12/controllers/product_controller.dart';
import 'package:untitled12/controllers/product_provider.dart';

import 'package:untitled12/models/product.dart';
import 'package:untitled12/views/add_to_cart.dart';
import 'package:untitled12/views/loginPage.dart';
import 'package:untitled12/views/my_account_page.dart';
import 'package:untitled12/views/productsbyCategoryId.dart';
import 'package:untitled12/views/view_cart_page.dart';

import '../controllers/api_helper.dart';
import '../controllers/category_controller.dart';
import '../controllers/category_provider.dart';
import '../controllers/imagebannar_provider.dart';
import '../controllers/imagebanner_controller.dart';
import '../controllers/user_controller.dart';
import '../models/category.dart';
import '../models/image_bannar.dart';
import '../models/user.dart';
import 'checkBase64Image.dart';


 class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  List<Category> categories = [];
  List<ImageBannarModel> imageBanners = [];
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    fetchCategories();
    fetchImageBanners();
    fetchUserInfo(); // Fetch the user information when the widget initializes

  }

  Future<void> fetchCategories() async {
    try {
      final List<Category> fetchedCategories =
      await CategoryController().getAll();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      UserController userController = UserController();
      User fetchedUser = await userController.getUser();

      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      print('Failed to fetch user information: $e');
    }
  }


  void _handleCategorySelection(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryProductsPage(category: category),
      ),
    );
  }

  Future<void> fetchImageBanners() async {
    try {
      final List<ImageBannarModel> fetchedImageBanners =
      await ImagebannerController().getAll();
      setState(() {
        imageBanners = fetchedImageBanners;
      });
    } catch (error) {
      print('Error fetching image banners: $error');
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar:   AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.blue, // Set desired background color
                child: Transform.translate(
                  offset: Offset(0, -3), // Adjust the offset as needed
                  child: Image.asset(
                    'assets/images/logo.png',

                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'More Options',
                      style: TextStyle( 
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (user != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user!.firstName} ${user!.lastName}', // Display the user's first name and last name
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),


                              Text(
                                'Country: ${user!.country}', // Display the user's country
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),



              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('My Account Page'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAccountPage(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Shop Cart'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewCart(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text('last orders'),
                onTap: () {
                  Navigator.pushNamed(context, '/orders'); // Navigate to the OrdersPage

                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await FlutterSecureStorage().delete(key: "token");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
              ),


            ],
          ),
        ),
      body: Container(
      decoration: BoxDecoration(
      image: DecorationImage(
      image: NetworkImage('your_image_url_here'),
      fit: BoxFit.cover,
      ),

      ),
        child: FutureBuilder(
          future: CategoryController().getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 20),
                                  itemBuilder: (context, index) {
                                    Category category = categories[index];
                                    return GestureDetector(
                                      onTap: () {
                                        _handleCategorySelection(category);
                                      },
                                      child: Column(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              category.image,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Text(category.name),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(
                              height: 200,
                              child: CarouselSlider.builder(
                                itemCount: imageBanners.length,
                                itemBuilder: (BuildContext context, int index, int realIndex) {
                                  ImageBannarModel imageBanner = imageBanners[index];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageBanner.image,
                                      width: 300,
                                      height: 1000,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlay: true, // Enable automatic scrolling
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  aspectRatio: 2.0,
                                  onPageChanged: (index, reason) {
                                    // Handle page change events if needed
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Products',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future: ProductController().getAll(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.done) {
                                  List<Product> products = snapshot.data as List<Product>;

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: products.length,
                                    separatorBuilder: (context, index) => SizedBox(height: 8), // Adjust the height for spacing
                                    itemBuilder: (context, index) {
                                      Product product = products[index];

                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        width: 300,
                                        height:150,// Adjust the width as desired
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
                                              height: 100,
                                              fit: BoxFit.fitHeight,
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
                                                    fontSize: 12, // Adjust the font size as desired
                                                  ),
                                                ),
                                                Text(
                                                  product.finalPrice.toStringAsFixed(2),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                    fontSize: 12, // Adjust the font size as desired
                                                   ),
                                                ),
                                                Text(
                                                  ' JD',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                    fontSize: 12, // Adjust the font size as desired
                                                  ),
                                                ),
                                              ],
                                            ),


                                          ),
                                        ),


                                      );
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),

                            const SizedBox(height: 100), // Add extra space at the bottom
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AddToCartWidget(),
                  ),
                ],
              );
            }

            return Container();
          },
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
                padding: const EdgeInsets.all(12.0),
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
                      ),
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
                    const SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text('Add to cart'),
                      onPressed: () {
                        var productProvider =
                        Provider.of<ProductProvier>(context, listen: false);
                        productProvider.addToCart(product);
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
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






























































  // void _handleCategorySelection(Category category) {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext sheetContext) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Container(
  //             height: 290,
  //             child: Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Text(
  //                     category.name,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   Text(category.image),
  //                   const SizedBox(height: 5),
  //                   // Other content for the bottom sheet
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

//
// import '../controllers/category_provider.dart';
// import '../models/category.dart';
// import 'list_view_categories.dart';
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 await FlutterSecureStorage().delete(key: "token");
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => RegisterPage(),
//                     ));
//               },
//               icon: Icon(Icons.logout)),
//           IconButton(
//               onPressed: () async {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DummyPage(),
//                     ));
//               },
//               icon: Icon(Icons.add)),
//
//           IconButton(
//               onPressed: () async {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MyAccountPage(),
//                     ));
//               },
//               icon: Icon(Icons.account_circle_rounded))
//         ],
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//                 child: FutureBuilder(
//                   future: ProductController().getAll(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       return ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           Product product = snapshot.data![index];
//                           return ListTile(
//                             onTap: () {
//                               _handleViewProduct(product);
//                             },
//                             leading: Image.network(
//                               product.image,
//                               width: 70,
//                               height: 70,
//                               fit: BoxFit.cover,
//                             ),
//                             title: Text(product.producTitle),
//                             subtitle: Text(product.category.name),
//                             trailing: Text(
//                               product.finalPrice.toStringAsFixed(2),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, color: Colors.green),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                     return Container();
//                   },
//                 )),
//             AddToCartWidget()
//           ],
//         ),
//       ),
//     );
//   }
//
//   _handleViewProduct(Product product) {
//     showModalBottomSheet<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 height: 230,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Text(
//                         product.producTitle,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         product.category.name,
//                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   product.selectedQty++;
//                                 });
//                               },
//                               icon: Icon(Icons.add)),
//                           const SizedBox(width: 30),
//                           Text(
//                             "${product.selectedQty}",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                                 fontSize: 18),
//                           ),
//                           const SizedBox(width: 30),
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   product.selectedQty--;
//                                 });
//                               },
//                               icon: Icon(Icons.remove)),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       ElevatedButton(
//                         child: const Text('Add to cart'),
//                         onPressed: () {
//                           var productProvider = Provider.of<ProductProvier>(
//                               context,
//                               listen: false);
//
//                           productProvider.addToCart(product);
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         });
//   }
// }





// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await FlutterSecureStorage().delete(key: "token");
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => RegisterPage(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.logout),
//           ),
//           IconButton(
//             onPressed: () async {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DummyPage(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.add),
//           ),
//           IconButton(
//             onPressed: () async {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MyAccountPage(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.account_circle_rounded),
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           Expanded(
//             child: FutureBuilder(
//               future: ProductController().getAll(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       Product product = snapshot.data![index];
//                       return ListTile(
//                         onTap: () {
//                           _handleViewProduct(product);
//                         },
//                         leading: Image.network(
//                           product.image,
//                           width: 70,
//                           height: 70,
//                           fit: BoxFit.cover,
//                         ),
//                         title: Text(product.producTitle),
//                         subtitle: Text(product.category.name),
//                         trailing: Text(
//                           product.finalPrice.toStringAsFixed(2),
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Container();
//               },
//             ),
//           ),
//           AddToCartWidget(),
//         ],
//       ),
//     );
//   }
//
//   _handleViewProduct(Product product) {
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Container(
//               height: 230,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       product.producTitle,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       product.category.name,
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               product.selectedQty++;
//                             });
//                           },
//                           icon: Icon(Icons.add),
//                         ),
//                         const SizedBox(width: 30),
//                         Text(
//                           "${product.selectedQty}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const SizedBox(width: 30),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               product.selectedQty--;
//                             });
//                           },
//                           icon: Icon(Icons.remove),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 30),
//                     ElevatedButton(
//                       child: const Text('Add to cart'),
//                       onPressed: () {
//                         var productProvider =
//                             Provider.of<ProductProvier>(context, listen: false);
//
//                         productProvider.addToCart(product);
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
