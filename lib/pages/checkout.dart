import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/config.dart';
import '../model/controller.dart';
import 'payment.dart';

void main() => runApp(const Checkout());

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.put(GeneralController());
    final CheckoutController ch = Get.put(CheckoutController());

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
        title: const Text('Checkout'),
      ),
      body: Obx(
        () => ch.itemList.isEmpty
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
            : SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: gen.resWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "Checkout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: gen.resWidth * 0.065,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: gen.scrHeight * 0.025),
                          Column(
                            children: <Widget>[
                              Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    children: [
                                      ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                  height:
                                                      gen.scrHeight * 0.015),
                                              const Divider(color: Colors.grey),
                                            ],
                                          );
                                        },
                                        itemCount:
                                            ch.itemList.length, // total orders
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                  height:
                                                      gen.scrHeight * 0.025),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: DropShadowImage(
                                                        image: Image.network(
                                                            Config.server +
                                                                'dg_homebakery/images/product/' +
                                                                ch.itemList[index]['prod_id']
                                                                    .toString() +
                                                                '.jpg',
                                                            width: gen.resWidth /
                                                                4,
                                                            height: gen.scrHeight /
                                                                8,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (BuildContext
                                                                    context,
                                                                Object exception,
                                                                StackTrace? stackTrace) {
                                                          return const Icon(Icons
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
                                                            const Offset(3, 3),
                                                        scale: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          gen.resWidth * 0.035),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ch.itemList[index]
                                                              ['prod_name'],
                                                          style: TextStyle(
                                                            fontSize:
                                                                gen.resWidth *
                                                                    0.05,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              style: TextStyle(
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
                                                              style: TextStyle(
                                                                fontSize:
                                                                    gen.resWidth *
                                                                        0.04,
                                                              ),
                                                            ),
                                                            Obx(
                                                              () => Text(
                                                                ch.itemList[
                                                                        index][
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
                                                              style: TextStyle(
                                                                fontSize:
                                                                    gen.resWidth *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Obx(
                                                              () => Text(
                                                                ch.itemList[
                                                                        index][
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
                                      SizedBox(height: gen.scrHeight * 0.025),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      SizedBox(height: gen.scrHeight * 0.035),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total: ',
                                            style: TextStyle(
                                              fontSize: gen.resWidth * 0.05,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              'RM ' +
                                                  ch.totalPrice
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontSize: gen.resWidth * 0.05,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: gen.scrHeight * 0.035),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.attach_money_rounded,
                                ),
                                onPressed: () => Get.to(() => const Payment()),
                                label: Text(
                                  "Pay",
                                  style:
                                      TextStyle(fontSize: gen.resWidth * 0.035),
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      gen.resWidth / 3, gen.scrHeight / 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
