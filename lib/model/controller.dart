import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../pages/main_page.dart';
import '../pages/product.dart';
import '../pages/product_details.dart';
import 'config.dart';
import 'user.dart';

// General
class GeneralController extends GetxController {
  late double scrHeight, scrWidth, resWidth;

  var pwVal = false.obs;
  var passVisible = true.obs;
  var checked = false.obs;
  var saveCred = false.obs;
  var changeVer = false.obs;
}

// Splash
class SplashController extends GetxController {
  late User user;

  Future<void> _checkAndLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = (pref.getString('email')) ?? '';
    String pass = (pref.getString('pass')) ?? '';

    if (email.isNotEmpty && pass.isNotEmpty) {
      http.post(Uri.parse(Config.server + "/dg_homebakery/php/user/login.php"),
          body: {
            "email": email,
            "pass": pass,
          }).then((response) {
        // cred stored, login success
        if (response.statusCode == 200 && response.body != "failed") {
          final jsonResponse = jsonDecode(response.body);
          user = User.fromJson(jsonResponse);
          Timer(const Duration(seconds: 3),
              () => Get.off(() => MainPage(), arguments: user));
        } else {
          // cred stored, login failed
          user = User(
            id: "NA",
            name: "NA",
            email: "NA",
            phone: "NA",
            address: "NA",
            otp: "NA",
            status: "NA",
          );
          Timer(const Duration(seconds: 3),
              () => Get.off(() => MainPage(), arguments: user));
        }
      }).timeout(const Duration(seconds: 5));
    } else {
      // cred empty
      user = User(
        id: "NA",
        name: "NA",
        email: "NA",
        phone: "NA",
        address: "NA",
        otp: "NA",
        status: "NA",
      );
      Timer(const Duration(seconds: 3),
          () => Get.off(() => MainPage(), arguments: user));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _checkAndLogin();
  }
}

// MainPage
class MainPageController extends GetxController {
  var userDet = Get.arguments;
}

final MainPageController mp = Get.put(MainPageController());

// Cart
class CartController extends GetxController {
  var cartList = [].obs;

  String userID = mp.userDet.id;

  loadCart() async {
    http.post(
        Uri.parse(Config.server + "/dg_homebakery/php/product/view_cart.php"),
        body: {"user_id": userID}).then((response) {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var cartData = parsedJson['cart'];

        if (cartData != "no data") {
          cartList.value = cartData;
        }
      } else {
        Fluttertoast.showToast(
          msg: "Cart data not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14,
        );
      }
    });
  }

  add(int index) {
    http.post(
        Uri.parse(
            Config.server + "/dg_homebakery/php/product/add_cart_item.php"),
        body: {
          "user_id": userID,
          "prod_id": cartList[index]['prod_id'],
        }).then((response) {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var data = parsedJson['status'];

        if (data == 'success') {
          loadCart();
        }
      } else {
        Fluttertoast.showToast(
          msg: "Failed to add item quantity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14,
        );
      }
    });
  }

  subtract(int index) {
    http.post(
        Uri.parse(Config.server +
            "/dg_homebakery/php/product/subtract_cart_item.php"),
        body: {
          "user_id": userID,
          "prod_id": cartList[index]['prod_id'],
        }).then((response) {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var data = parsedJson['status'];

        if (data == 'success') {
          loadCart();
        }
      } else {
        Fluttertoast.showToast(
          msg: "Failed to reduce item quantity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14,
        );
      }
    });
  }

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }
}

// Category
class CategoryController extends GetxController {
  var catList = [].obs;
  var results = "Data Not Found".obs;
  var gridCount = 2.obs;
  Random rand = Random();
}

class LoadCategory extends GetConnect {
  final CategoryController cat = Get.put(CategoryController());

  Future<dynamic> loadCat() async {
    var response =
        await get(Config.server + "/dg_homebakery/php/product/category.php");
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      var parsedJson = await response.body;
      var catData = parsedJson['category'];

      if (catData != "no data") {
        cat.catList.value = catData;
        cat.results.value = "Results Found: ";
      }
    }
  }

  @override
  void onInit() {
    loadCat();
    super.onInit();
  }

  fetchCat(int index) async {
    await Get.to(() => const Product(),
        arguments: cat.catList[index]['category']);
  }
}

// ChangePw (Form)
class ChangePwController extends GetxController {
  var oldPassEC = TextEditingController().obs;
  var newPassEC = TextEditingController().obs;
  var conNewPassEC = TextEditingController().obs;

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  final formKey = GlobalKey<FormState>();
}

// Checkout
class CheckoutController extends GetxController {
  var itemList = [].obs;
  var totalPrice = (0.00).obs;

  String userID = mp.userDet.id;

  loadItems() async {
    http.post(
        Uri.parse(Config.server + "/dg_homebakery/php/product/view_cart.php"),
        body: {"user_id": userID}).then((response) {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var itemData = parsedJson['cart'];

        if (itemData != "no data") {
          itemList.value = itemData;
          for (int i = 0; i < itemList.length; i++) {
            int itemQty = int.parse(itemList[i]['quantity']);
            double itemPrice = double.parse(itemList[i]['price']);
            totalPrice.value += (itemQty * itemPrice);
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: "Checkout data not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14,
        );
      }
    });
  }

  @override
  void onInit() {
    loadItems();
    super.onInit();
  }
}

// ConfirmUser (Form)
class ConfirmUserController extends GetxController {
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController otpEC = TextEditingController();

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();

  final formKey = GlobalKey<FormState>();
}

// EditProfile (Form)
class EditProfileController extends GetxController {
  final MainPageController mp = Get.find();

  var nameEC = TextEditingController().obs;
  var emailEC = TextEditingController().obs;
  var phoneEC = TextEditingController().obs;
  var addEC = TextEditingController().obs;

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    nameEC.value.text = mp.userDet.name;
    emailEC.value.text = mp.userDet.email;
    phoneEC.value.text = mp.userDet.phone;
    addEC.value.text = mp.userDet.address != "N/A" ? mp.userDet.address : "";
    super.onInit();
  }
}

// Home
class HomeController extends GetxController {
  var prodList = [].obs;
  var results = "Data Not Found".obs;
  var gridCount = 2.obs;

  fetchProd(int index) async {
    await Get.to(() => const ProductDetails(), arguments: {
      "id": prodList[index]['id'],
      "name": prodList[index]['name'],
      "description": prodList[index]['description'],
      "category": prodList[index]['category'],
      "price": prodList[index]['price'],
      "date_created": DateTime.tryParse(prodList[index]['date_created']),
    });
  }
}

class LoadLatest extends GetConnect {
  final HomeController latest = Get.put(HomeController());

  Future<dynamic> loadLat() async {
    var response =
        await get(Config.server + "/dg_homebakery/php/product/latest.php");
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      var parsedJson = await response.body;
      var latData = parsedJson['latest'];

      if (latData != "no data") {
        latest.prodList.value = latData;
        latest.results.value = "Results Found: ";
      }
    }
  }

  @override
  void onInit() {
    loadLat();
    super.onInit();
  }
}

// Login (Form)
class LoginController extends GetxController {
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passEC = TextEditingController();

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();

  final formKey = GlobalKey<FormState>();
}

// OrderHistory
class OrderHistoryController extends GetxController {
  var orderList = [].obs;

  String userID = mp.userDet.id;

  loadOrderHistory() async {
    http.post(
        Uri.parse(
            Config.server + "/dg_homebakery/php/orders/order_history.php"),
        body: {"user_id": userID}).then((response) {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var orderData = parsedJson['order'];

        if (orderData != "no data") {
          orderList.value = orderData;
        }
      } else {
        Fluttertoast.showToast(
          msg: "Order history data not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14,
        );
      }
    });
  }

  @override
  void onInit() {
    loadOrderHistory();
    super.onInit();
  }
}

// Payment
class PaymentController extends GetxController {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}

// Product
class ProductController extends GetxController {
  var prodList = [].obs;
  var results = "Data Not Found".obs;
  var gridCount = 2.obs;

  late ScrollController scrollController;
  var scrollCount = 6.obs;
  var data = Get.arguments;

  loadProd() async {
    http.post(
        Uri.parse(Config.server + "/dg_homebakery/php/product/product.php"),
        body: {"category": data}).then((response) {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        var prodData = parsedJson['product'];

        if (prodData != "no data") {
          prodList.value = prodData;
          results.value = "Results Found";
        }
      } else {
        results.value = "No data found";
      }
    });
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (prodList.length > scrollCount.value) {
        scrollCount = scrollCount + 6;
        if (scrollCount > prodList.length) {
          scrollCount.value = prodList.length;
        }
      }
    }
  }

  @override
  void onInit() {
    loadProd();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  fetchProd(int index) async {
    await Get.to(() => const ProductDetails(), arguments: {
      "id": prodList[index]['id'],
      "name": prodList[index]['name'],
      "description": prodList[index]['description'],
      "category": prodList[index]['category'],
      "price": prodList[index]['price'],
      "date_created": DateTime.tryParse(prodList[index]['date_created']),
    });
  }
}

// ProductDetails
class ProductDetailsController extends GetxController {
  var proDetails = Get.arguments;
}

// Profile
class ProfileController extends GetxController {
  final GeneralController gen = Get.put(GeneralController());
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passEC = TextEditingController();

  Future<void> loadCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String email = (pref.getString('email')) ?? '';
    String pass = (pref.getString('pass')) ?? '';

    if (email.isNotEmpty && pass.isNotEmpty) {
      emailEC.text = email;
      passEC.text = pass;
      gen.saveCred.value = true;
    }
  }

  @override
  void onInit() {
    loadCred();
    super.onInit();
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('email', '');
    await pref.setString('pass', '');
    gen.saveCred.value = false;

    User user = User(
      id: "NA",
      name: "NA",
      email: "NA",
      phone: "NA",
      address: "NA",
      otp: "NA",
      status: "NA",
    );

    Fluttertoast.showToast(
      msg: "Logout successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 14,
    );

    Get.offAll(MainPage(), arguments: user);
  }

  verify() {
    final MainPageController mp = Get.find();

    var email = mp.userDet.email;
    var otp = mp.userDet.otp;

    http.post(
        Uri.parse(Config.server + "/dg_homebakery/php/user/send_email.php"),
        body: {
          "email": email,
          "otp": otp,
        }).then((response) {
      Fluttertoast.showToast(
        msg: "Verification email has been sent. Please verify your account.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14,
      );
    });
  }
}

// Register (Form)
class RegisterController extends GetxController {
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController phoneEC = TextEditingController();
  final TextEditingController passEC = TextEditingController();
  final TextEditingController confirmPassEC = TextEditingController();

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();

  final formKey = GlobalKey<FormState>();

  var eula = "".obs;
}

// ResetPw (Form)
class ResetPwController extends GetxController {
  var data = Get.arguments;

  var newPassEC = TextEditingController().obs;
  var conNewPassEC = TextEditingController().obs;

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();

  final formKey = GlobalKey<FormState>();
}

// Seller
class SellerController extends GetxController {
  launchWA() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+601161751807',
      text: "Hey! I'm inquiring about DoughyGoodness Home Bakery.",
    );
    await launch('$link');
  }
}
