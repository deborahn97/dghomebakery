import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

import '../model/config.dart';
import '../model/controller.dart';

void main() => runApp(const ProductDetails());

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final ProductDetailsController pD = Get.put(ProductDetailsController());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 229, 248),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details'),
      ),
      body: pD.proDetails.isEmpty
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    "   Loading...",
                    style: TextStyle(
                      fontSize: gen.resWidth * 0.06,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: SizedBox(
                width: gen.resWidth * 2,
                height: gen.scrHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            pD.proDetails['name'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: gen.resWidth * 0.065,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              shadows: const [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.025),
                        SimpleShadow(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: DropShadowImage(
                              image: Image.network(
                                  Config.server +
                                      'dg_homebakery/images/product/' +
                                      pD.proDetails['id'].toString() +
                                      '.jpg',
                                  height: gen.scrHeight / 3,
                                  fit: BoxFit.cover, errorBuilder:
                                      (BuildContext context, Object exception,
                                          StackTrace? stackTrace) {
                                return const Icon(Icons.stop_circle_rounded);
                              }, loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return LinearProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                );
                              }),
                              borderRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(3, 3),
                              scale: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.05),
                        SizedBox(
                          width: gen.resWidth,
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.description_rounded,
                                          color: Colors.purple),
                                      SizedBox(width: gen.resWidth * 0.035),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Description',
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                pD.proDetails['description']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      gen.resWidth * 0.045,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.025),
                                  Row(
                                    children: [
                                      const Icon(Icons.sell_rounded,
                                          color: Colors.purple),
                                      SizedBox(width: gen.resWidth * 0.035),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Price',
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "RM " +
                                                    pD.proDetails['price']
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      gen.resWidth * 0.045,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.025),
                                  Row(
                                    children: [
                                      const Icon(Icons.post_add_rounded,
                                          color: Colors.purple),
                                      SizedBox(width: gen.resWidth * 0.035),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Posted on',
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                DateFormat('d MMM yyyy hh:mm a')
                                                    .format(pD.proDetails[
                                                        'date_created']),
                                                style: TextStyle(
                                                  fontSize:
                                                      gen.resWidth * 0.045,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.025),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.025),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.shopping_cart_rounded,
                          ),
                          onPressed: addCart,
                          label: Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: gen.resWidth * 0.035),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(gen.resWidth / 3, gen.scrHeight / 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  final MainPageController mp = Get.put(MainPageController());
  final ProductDetailsController pD = Get.put(ProductDetailsController());

  addCart() {
    String userID = mp.userDet.id.toString();
    String userStatus = mp.userDet.status.toString();
    String prodID = pD.proDetails['id'];
    String prodName = pD.proDetails['name'];
    String prodPrice = pD.proDetails['price'];

    if (userID == "NA") {
      Fluttertoast.showToast(
        msg: "Please login to add item to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14,
      );
      return;
    } else if (userStatus != "Verified") {
      Fluttertoast.showToast(
        msg: "Please login to add item to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14,
      );
      return;
    } else {
      ProgressDialog progress = ProgressDialog(
        context,
        title: const Text("Add to Cart"),
        message: const Text("Adding to your cart..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/product/add_cart.php"),
          body: {
            "user_id": userID,
            "prod_id": prodID,
            "prod_name": prodName,
            "prod_price": prodPrice,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] != 'failed') {
          Fluttertoast.showToast(
            msg: "Item added to cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
          return;
        } else {
          Fluttertoast.showToast(
            msg: "Failed to add item. Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
          return;
        }
      });
    }
  }
}
