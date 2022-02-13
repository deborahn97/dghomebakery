import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../model/config.dart';
import '../model/controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final HomeController lat = Get.find();
    Get.put(LoadLatest());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
      lat.gridCount.value = 2;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
      lat.gridCount.value = 3;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 229, 248),
      body: Obx(
        () => lat.prodList.isEmpty
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Latest Products",
                          style: TextStyle(
                            fontSize: gen.resWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.035),
                        Expanded(
                          child: Obx(
                            () => GridView.count(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              crossAxisCount: lat.gridCount.value,
                              children: List.generate(
                                lat.prodList.length,
                                (index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.5),
                                          child: GestureDetector(
                                            onTap: (() => {
                                                  lat.fetchProd(index),
                                                }),
                                            child: Stack(
                                              children: [
                                                SimpleShadow(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Image.network(
                                                        Config.server +
                                                            'dg_homebakery/images/product/' +
                                                            lat.prodList[index]
                                                                    ['id']
                                                                .toString() +
                                                            '.jpg',
                                                        errorBuilder: (BuildContext
                                                                context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return const Icon(Icons
                                                          .stop_circle_rounded);
                                                    }, loadingBuilder: (BuildContext
                                                                context,
                                                            Widget child,
                                                            ImageChunkEvent?
                                                                loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
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
                                                  ),
                                                  opacity: 0.6,
                                                  color: Colors.black,
                                                  offset: const Offset(3, 3),
                                                  sigma: 2,
                                                ),
                                                Positioned.fill(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      color: Colors.black54,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7.0),
                                                      child: Text(
                                                        lat.prodList[index]
                                                            ['name'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              gen.resWidth *
                                                                  0.045,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
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
