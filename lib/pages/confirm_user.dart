import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../model/config.dart';
import '../model/controller.dart';
import 'reset_pw.dart';

void main() => runApp(const ConfirmUser());

class ConfirmUser extends StatefulWidget {
  const ConfirmUser({Key? key}) : super(key: key);

  @override
  State<ConfirmUser> createState() => _ConfirmUserState();
}

class _ConfirmUserState extends State<ConfirmUser> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final ConfirmUserController cU = Get.put(ConfirmUserController());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
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
                        Text(
                          "Enter Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: gen.resWidth * 0.075,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.035),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: cU.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    validator: (val) => val!.isEmpty ||
                                            !val.contains("@") ||
                                            !val.contains(".")
                                        ? "Please enter a valid email"
                                        : null,
                                    focusNode: cU.focus,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(cU.focus1);
                                    },
                                    controller: cU.emailEC,
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
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    validator: (val) => val!.isEmpty
                                        ? "Please enter OTP number"
                                        : null,
                                    focusNode: cU.focus1,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(cU.focus2);
                                    },
                                    controller: cU.otpEC,
                                    decoration: const InputDecoration(
                                      labelText: 'OTP Number',
                                      labelStyle: TextStyle(),
                                      icon: Icon(Icons.sms_rounded),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: gen.scrHeight * 0.035),
                                  OutlinedButton(
                                    onPressed: _reqOTP,
                                    child: const Text(
                                      "Request OTP",
                                      textAlign: TextAlign.center,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(8.0),
                                      shape: const StadiumBorder(),
                                      side: const BorderSide(
                                        width: 1.0,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.055),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.check_rounded,
                          ),
                          onPressed: _checkUserExists,
                          label: Text(
                            "Submit",
                            style: TextStyle(fontSize: gen.resWidth * 0.035),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(gen.scrWidth / 3, gen.scrHeight / 15),
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

  final GeneralController gen = Get.find();
  final ConfirmUserController cU = Get.put(ConfirmUserController());

  _reqOTP() {
    String email = cU.emailEC.text;

    if (email.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    } else {
      ProgressDialog progress = ProgressDialog(
        context,
        title: const Text("Request OTP"),
        message: const Text("Sending OTP to your email..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/user/get_otp.php"),
          body: {
            "email": email,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "OTP sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
          return;
        } else {
          Fluttertoast.showToast(
            msg:
                "Failed to send OTP. Please make sure your entered the correct email",
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

  _checkUserExists() {
    String email = cU.emailEC.text;
    String otp = cU.otpEC.text;

    if (!cU.formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please make sure details are complete",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    } else {
      ProgressDialog progress = ProgressDialog(
        context,
        title: const Text("Checking Account"),
        message: const Text("Checking your account details..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/user/check_otp.php"),
          body: {
            "email": email,
            "otp": otp,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          progress.dismiss();
          Get.to(() => const ResetPw(), arguments: cU.emailEC.text);
        } else {
          Fluttertoast.showToast(
            msg: "Please make sure the details you entered are correct",
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
