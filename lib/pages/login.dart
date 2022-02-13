import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/config.dart';
import '../model/controller.dart';
import '../model/user.dart';
import 'confirm_user.dart';
import 'main_page.dart';
import 'register.dart';

void main() => runApp(const Login());

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final LoginController l = Get.put(LoginController());

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/login.png',
                              scale: 30,
                            ),
                            SizedBox(width: gen.resWidth * 0.025),
                            Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: gen.resWidth * 0.075,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: gen.scrHeight * 0.035),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Form(
                              key: l.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    validator: (val) => val!.isEmpty ||
                                            !val.contains("@") ||
                                            !val.contains(".")
                                        ? "Please enter a valid email"
                                        : null,
                                    focusNode: l.focus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(l.focus1);
                                    },
                                    controller: l.emailEC,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'E-mail',
                                      labelStyle: TextStyle(),
                                      icon: Icon(Icons.email_rounded),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.035),
                                  Obx(
                                    () => TextFormField(
                                      textInputAction: TextInputAction.done,
                                      validator: (val) => val!.isEmpty
                                          ? "Please enter a password"
                                          : null,
                                      focusNode: l.focus1,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(l.focus2);
                                      },
                                      controller: l.passEC,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: const TextStyle(),
                                        icon: const Icon(Icons.lock_rounded),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            gen.passVisible.value
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                          ),
                                          onPressed: () {
                                            gen.passVisible.value =
                                                !gen.passVisible.value;
                                          },
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      obscureText: gen.passVisible.value,
                                    ),
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.035),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          value: gen.saveCred.value,
                                          onChanged: (bool? value) {
                                            _storeCred(value!);
                                          },
                                        ),
                                      ),
                                      const Text(
                                        "Remember Me",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.035),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.login_rounded,
                                    ),
                                    onPressed: _login,
                                    label: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: gen.resWidth * 0.035),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                          gen.resWidth / 3, gen.scrHeight / 15),
                                    ),
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.035),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not a Member? ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Register());
                              },
                              child: const Text(
                                "Register Here",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: gen.scrHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Forgot Password? ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ConfirmUser());
                              },
                              child: const Text(
                                "Tap Here to Reset",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
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
            ),
          ),
        ),
      ),
    );
  }

  final GeneralController gen = Get.find();
  final LoginController l = Get.find();

  _storeCred(bool bool) {
    gen.saveCred.value = bool;
    if (gen.saveCred.value) {
      _rememberMe(true);
    } else {
      _rememberMe(false);
    }
  }

  _rememberMe(bool value) async {
    if (!l.formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in your login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      gen.saveCred.value = false;
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();

    String email = l.emailEC.text;
    String pass = l.passEC.text;

    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value) {
      // save credentials
      await pref.setString('email', email);
      await pref.setString('pass', pass);
    } else {
      // remove credentials
      await pref.setString('email', '');
      await pref.setString('pass', '');

      l.emailEC.text = '';
      l.passEC.text = '';
      gen.saveCred.value = false;
    }
  }

  _login() {
    Get.lazyPut(() => MainPageController());
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();

    if (!l.formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      gen.saveCred.value = false;
      return;
    }

    ProgressDialog progress = ProgressDialog(
      context,
      title: const Text("Login"),
      message: const Text("Logging in to your account..."),
    );

    progress.show();

    String email = l.emailEC.text;
    String pass = l.passEC.text;

    http.post(Uri.parse(Config.server + "/dg_homebakery/php/user/login.php"),
        body: {
          "email": email,
          "pass": pass,
        }).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = jsonDecode(response.body);
        User user = User.fromJson(jsonResponse);
        Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);

        progress.dismiss();
        Get.offAll(MainPage(), arguments: user);
      } else {
        Fluttertoast.showToast(
            msg: "Login failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
      progress.dismiss();
    });
  }
}
