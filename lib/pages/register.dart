import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../model/config.dart';
import '../model/controller.dart';

void main() => runApp(const Register());

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final RegisterController reg = Get.put(RegisterController());

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
        title: const Text('DoughyGoodness Home Bakery'),
      ),
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
                              'assets/images/register.png',
                              scale: 11,
                            ),
                            SizedBox(width: gen.resWidth * 0.025),
                            Text(
                              "Register",
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
                              key: reg.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    validator: (val) => val!.isEmpty ||
                                            (val.length < 5)
                                        ? "Name must be longer than 5 characters"
                                        : null,
                                    focusNode: reg.focus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(reg.focus1);
                                    },
                                    controller: reg.nameEC,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(),
                                      icon: Icon(
                                          Icons.supervised_user_circle_rounded),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    validator: (val) => val!.isEmpty ||
                                            !val.contains("@") ||
                                            !val.contains(".")
                                        ? "Please enter a valid email"
                                        : null,
                                    focusNode: reg.focus1,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(reg.focus2);
                                    },
                                    controller: reg.emailEC,
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
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    validator: (val) => (val!.isEmpty) ||
                                            (val.length < 10)
                                        ? "Please enter a valid phone number"
                                        : null,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    focusNode: reg.focus2,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(reg.focus3);
                                    },
                                    controller: reg.phoneEC,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Phone No.',
                                      labelStyle: TextStyle(),
                                      icon: Icon(Icons.phone_rounded),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => TextFormField(
                                      textInputAction: TextInputAction.done,
                                      validator: (val) => val!.isEmpty
                                          ? "Please enter a password"
                                          : null,
                                      focusNode: reg.focus3,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(reg.focus4);
                                      },
                                      controller: reg.passEC,
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
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: FlutterPwValidator(
                                      controller: reg.passEC,
                                      minLength: 8,
                                      uppercaseCharCount: 1,
                                      numericCharCount: 2,
                                      specialCharCount: 1,
                                      width: gen.resWidth / 1.5,
                                      height: gen.scrHeight / 6,
                                      successColor: Colors.deepPurpleAccent,
                                      onSuccess: () => {gen.pwVal.value = true},
                                    ),
                                  ),
                                  Obx(
                                    () => TextFormField(
                                      textInputAction: TextInputAction.done,
                                      validator: (val) {
                                        if (val != reg.passEC.text) {
                                          return "Please make sure passwords match";
                                        } else if (val!.isEmpty) {
                                          return "Please enter a password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      focusNode: reg.focus4,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(reg.focus5);
                                      },
                                      controller: reg.confirmPassEC,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
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
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(
                                            () => Checkbox(
                                              value: gen.checked.value,
                                              onChanged: (bool? value) {
                                                gen.checked.value = value!;
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: _showEULA,
                                            child: const Text(
                                              "Accept Terms",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(gen.resWidth / 3, 50)),
                                    child: const Text("Register"),
                                    onPressed: _regAcc,
                                  ),
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
                              "Already registered? ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                "Login Here",
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

  Future<void> _showEULA() async {
    final RegisterController reg = Get.find();
    reg.eula.value = await rootBundle.loadString('assets/eula.txt');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("EULA"),
            content: SizedBox(
              height: gen.scrHeight / 1.5,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          text: reg.eula.value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _regAcc() async {
    final RegisterController reg = Get.find();
    if (!reg.formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Please fill in the correct details",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14,
      );
      return;
    } else if (gen.pwVal.value != true) {
      Fluttertoast.showToast(
        msg: "Please make sure the password is correct",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14,
      );
      return;
    } else if (!gen.checked.value) {
      Fluttertoast.showToast(
        msg: "Please accept the terms and conditions",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14,
      );
      return;
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      String _name = reg.nameEC.text;
      String _email = reg.emailEC.text;
      String _phone = reg.phoneEC.text;
      String _pass = reg.passEC.text;
      FocusScope.of(context).unfocus();

      ProgressDialog progress = ProgressDialog(
        context,
        title: const Text("Registration"),
        message: const Text("Registering your account..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/user/register.php"),
          body: {
            "name": _name,
            "email": _email,
            "phone": _phone,
            "pass": _pass,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Your account has been successfully registered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
          return;
        } else {
          Fluttertoast.showToast(
            msg: "Failed to register. Please try again",
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
