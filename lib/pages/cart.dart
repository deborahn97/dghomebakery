import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../model/config.dart';
import '../model/controller.dart';
import 'login.dart';
import 'checkout.dart';

void main() => runApp(const Cart());

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final MainPageController mp = Get.put(MainPageController());
    final CartController c = Get.put(CartController());
    Get.lazyPut(() => LoginController());
    c.loadCart();

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 229, 248),
      body: mp.userDet.id == "NA"
          ? const Login()
          : SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: gen.resWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "My Cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: gen.resWidth * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.025),
                        Obx(
                          () => c.cartList.isEmpty
                              ? SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: gen.resWidth,
                                          child: Card(
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(25.0),
                                              child: Text(
                                                'Your cart is empty.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: gen.resWidth * 0.05,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          children: [
                                            ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                        height: gen.scrHeight *
                                                            0.015),
                                                    const Divider(
                                                        color: Colors.grey),
                                                  ],
                                                );
                                              },
                                              itemCount: c.cartList.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                        height: gen.scrHeight *
                                                            0.025),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child:
                                                                DropShadowImage(
                                                              image: Image.network(
                                                                  Config.server +
                                                                      'dg_homebakery/images/product/' +
                                                                      c.cartList[index]['prod_id']
                                                                          .toString() +
                                                                      '.jpg',
                                                                  width: gen.resWidth /
                                                                      4,
                                                                  height:
                                                                      gen.scrHeight /
                                                                          8,
                                                                  fit: BoxFit.cover,
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object exception,
                                                                      StackTrace? stackTrace) {
                                                                return const Icon(
                                                                    Icons
                                                                        .stop_circle_rounded);
                                                              }, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null) {
                                                                  return child;
                                                                }
                                                                return LinearProgressIndicator(
                                                                  value: loadingProgress
                                                                              .expectedTotalBytes !=
                                                                          null
                                                                      ? loadingProgress
                                                                              .cumulativeBytesLoaded /
                                                                          loadingProgress
                                                                              .expectedTotalBytes!
                                                                      : null,
                                                                );
                                                              }),
                                                              borderRadius: 5,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      3, 3),
                                                              scale: 1,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                gen.resWidth *
                                                                    0.035),
                                                        Expanded(
                                                          flex: 7,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                c.cartList[
                                                                        index][
                                                                    'prod_name'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      gen.resWidth *
                                                                          0.05,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      gen.scrHeight *
                                                                          0.015),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Price: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          gen.resWidth *
                                                                              0.04,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "RM",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          gen.resWidth *
                                                                              0.04,
                                                                    ),
                                                                  ),
                                                                  Obx(
                                                                    () => Text(
                                                                      c.cartList[
                                                                              index]
                                                                              [
                                                                              'price']
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            gen.resWidth *
                                                                                0.04,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Quantity: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          gen.resWidth *
                                                                              0.04,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .remove_rounded),
                                                                    tooltip:
                                                                        "Subtract",
                                                                    onPressed:
                                                                        () {
                                                                      c.subtract(
                                                                          index);
                                                                    },
                                                                  ),
                                                                  Obx(
                                                                    () => Text(
                                                                      c.cartList[
                                                                              index]
                                                                              [
                                                                              'quantity']
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            gen.resWidth *
                                                                                0.04,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .add_rounded),
                                                                    tooltip:
                                                                        "Add",
                                                                    onPressed:
                                                                        () {
                                                                      c.add(
                                                                          index);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            SizedBox(
                                                height: gen.scrHeight * 0.025),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: gen.scrHeight * 0.035),
                                    ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.shopping_cart_rounded,
                                      ),
                                      onPressed: () {
                                        if (mp.userDet.status != "Verified") {
                                          Fluttertoast.showToast(
                                            msg:
                                                "Please verify your account before checking out",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 14,
                                          );
                                          return;
                                        } else {
                                          Get.to(() => const Checkout());
                                        }
                                      },
                                      label: Text(
                                        "Checkout",
                                        style: TextStyle(
                                            fontSize: gen.resWidth * 0.035),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(gen.resWidth / 3,
                                            gen.scrHeight / 15),
                                      ),
                                    ),
                                  ],
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
}
