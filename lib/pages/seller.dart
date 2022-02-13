import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/config.dart';
import '../model/controller.dart';

void main() => runApp(const Seller());

class Seller extends StatelessWidget {
  const Seller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final SellerController s = Get.put(SellerController());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 229, 248),
      body: Center(
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
                      "Seller Info",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: gen.resWidth * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: gen.scrHeight * 0.015),
                  SimpleShadow(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: DropShadowImage(
                        image: Image.network(
                            Config.server + 'dg_homebakery/images/seller.jpg',
                            height: gen.scrHeight / 3,
                            fit: BoxFit.cover, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                          return const Icon(Icons.stop_circle_rounded);
                        }, loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LinearProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
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
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: gen.resWidth,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.account_box_rounded,
                                    color: Colors.purple),
                                SizedBox(width: gen.resWidth * 0.035),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Name',
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Janira Jani".toString(),
                                          style: TextStyle(
                                            fontSize: gen.resWidth * 0.045,
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
                                const Icon(Icons.phone_rounded,
                                    color: Colors.purple),
                                SizedBox(width: gen.resWidth * 0.035),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Phone No.',
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "011-17461288",
                                          style: TextStyle(
                                            fontSize: gen.resWidth * 0.045,
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
                                const Icon(Icons.email_rounded,
                                    color: Colors.purple),
                                SizedBox(width: gen.resWidth * 0.035),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email',
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "jani@gmail.com",
                                          style: TextStyle(
                                            fontSize: gen.resWidth * 0.045,
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
                                const Icon(Icons.house_rounded,
                                    color: Colors.purple),
                                SizedBox(width: gen.resWidth * 0.035),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Address',
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Lot 39, Laluan 3 Simpang 9, Ampang, 40300 Shah Alam, Selangor.",
                                          style: TextStyle(
                                            fontSize: gen.resWidth * 0.045,
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
                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    onPressed: s.launchWA,
                    label: Text(
                      "WhatsApp",
                      style: TextStyle(fontSize: gen.resWidth * 0.035),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(gen.resWidth / 3, gen.scrHeight / 15),
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
