import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/config.dart';
import '../model/controller.dart';
import 'login.dart';

void main() => runApp(const OrderHistory());

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final MainPageController mp = Get.put(MainPageController());
    final OrderHistoryController oH = Get.put(OrderHistoryController());
    Get.lazyPut(() => LoginController());
    oH.loadOrderHistory();

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
                          "Order History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: gen.resWidth * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.025),
                        Obx(
                          () => oH.orderList.isEmpty
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
                                                'Your order history is empty.',
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
                              : SizedBox(
                                  child: Column(
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
                                                          height:
                                                              gen.scrHeight *
                                                                  0.015),
                                                      const Divider(
                                                          color: Colors.grey),
                                                    ],
                                                  );
                                                },
                                                itemCount: oH.orderList.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      SizedBox(
                                                          height:
                                                              gen.scrHeight *
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
                                                                        oH.orderList[index]['prod_id']
                                                                            .toString() +
                                                                        '.jpg',
                                                                    width:
                                                                        gen.resWidth /
                                                                            4,
                                                                    height:
                                                                        gen.scrHeight /
                                                                            8,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder: (BuildContext context,
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
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes!
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
                                                                  oH.orderList[
                                                                          index]
                                                                      [
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
                                                                    height: gen
                                                                            .scrHeight *
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
                                                                            FontWeight.bold,
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
                                                                      () =>
                                                                          Text(
                                                                        oH.orderList[index]['price']
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              gen.resWidth * 0.04,
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
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Obx(
                                                                      () =>
                                                                          Text(
                                                                        oH.orderList[index]['quantity']
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              gen.resWidth * 0.04,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Date: ",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            gen.resWidth *
                                                                                0.04,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Obx(
                                                                      () =>
                                                                          Flexible(
                                                                        child:
                                                                            Text(
                                                                          DateFormat('d MMM yyyy hh:mm a').format(DateTime.parse(oH.orderList[index]
                                                                              [
                                                                              'paid_date'])),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                gen.resWidth * 0.04,
                                                                          ),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
