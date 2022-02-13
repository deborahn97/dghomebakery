import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/config.dart';
import '../model/controller.dart';

void main() => runApp(const Payment());

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.put(GeneralController());
    final PaymentController p = Get.put(PaymentController());
    final MainPageController mp = Get.put(MainPageController());
    final CheckoutController ch = Get.put(CheckoutController());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    String userName = mp.userDet.name.toString();
    String userEmail = mp.userDet.email.toString();
    String userPhone = mp.userDet.phone.toString();
    List orderID = [];
    double totalPrice = ch.totalPrice.value;

    for (int i = 0; i < ch.itemList.length; i++) {
      orderID.add(ch.itemList[i]['id'].toString());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Payment'),
      ),
      body: Center(
        child: SizedBox(
          height: gen.scrHeight,
          width: gen.resWidth,
          child: WebView(
            initialUrl: Config.server +
                'dg_homebakery/php/orders/payment.php?orderid=' +
                orderID.toString() +
                '&name=' +
                userName +
                '&email=' +
                userEmail +
                '&phone=' +
                userPhone +
                '&total=' +
                totalPrice.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              p.controller.complete(webViewController);
            },
            onProgress: (int progress) {
              //print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              //print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              //print('Page finished loading: $url');
            },
          ),
        ),
      ),
    );
  }
}
