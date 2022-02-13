import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/controller.dart';
import 'category.dart';
import 'home.dart';
import 'cart.dart';
import 'order_history.dart';
import 'profile.dart';
import 'seller.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final MainPageController mp = Get.put(MainPageController());
  final GeneralController gen = Get.put(GeneralController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => ProfileController());

    var _index = 0.obs;
    List drawerList = [
      const Home(),
      Category(),
      const Cart(),
      const OrderHistory(),
      const Profile(),
      const Seller(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('DoughyGoodness Home Bakery'),
      ),
      body: Center(
        child: Obx(() => drawerList[_index.value]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.purple,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ]),
            ),
            ListTile(
              leading: const Icon(Icons.house_rounded, color: Colors.purple),
              title: const Text("Home"),
              onTap: (() => {
                    _index.value = 0,
                    Get.back(),
                  }),
            ),
            ListTile(
              leading: const Icon(Icons.category_rounded, color: Colors.purple),
              title: const Text("Categories"),
              onTap: (() => {
                    _index.value = 1,
                    Get.back(),
                  }),
            ),
            ListTile(
              leading:
                  const Icon(Icons.shopping_cart_rounded, color: Colors.purple),
              title: const Text("Cart"),
              onTap: (() => {
                    _index.value = 2,
                    Get.back(),
                  }),
            ),
            ListTile(
              leading:
                  const Icon(Icons.shopping_bag_rounded, color: Colors.purple),
              title: const Text("Order History"),
              onTap: (() => {
                    _index.value = 3,
                    Get.back(),
                  }),
            ),
            ListTile(
              leading: const Icon(Icons.supervisor_account_rounded,
                  color: Colors.purple),
              title: const Text("Profile"),
              onTap: (() => {
                    _index.value = 4,
                    Get.back(),
                  }),
            ),
            ListTile(
              leading:
                  const Icon(Icons.local_phone_rounded, color: Colors.purple),
              title: const Text("Seller Contact"),
              onTap: (() => {
                    _index.value = 5,
                    Get.back(),
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
