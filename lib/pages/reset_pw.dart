import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../model/config.dart';
import '../model/controller.dart';

void main() => runApp(const ResetPw());

class ResetPw extends StatefulWidget {
  const ResetPw({Key? key}) : super(key: key);

  @override
  State<ResetPw> createState() => _ResetPwState();
}

class _ResetPwState extends State<ResetPw> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final ResetPwController sP = Get.put(ResetPwController());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
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
                children: [
                  Column(
                    children: [
                      Text(
                        "Reset Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: gen.resWidth * 0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: gen.scrHeight * 0.025),
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: rP.formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: gen.scrHeight * 0.025),
                                        SizedBox(
                                          width: gen.resWidth / 1.5,
                                          child: Obx(
                                            () => TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (val) => val!.isEmpty
                                                  ? "New password field cannot be empty"
                                                  : null,
                                              focusNode: rP.focus,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(rP.focus1);
                                              },
                                              controller: sP.newPassEC.value,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: 'Enter New Password',
                                                labelStyle: const TextStyle(),
                                                border:
                                                    const OutlineInputBorder(),
                                                icon: const Icon(
                                                    Icons.lock_rounded),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    gen.passVisible.value
                                                        ? Icons
                                                            .visibility_rounded
                                                        : Icons
                                                            .visibility_off_rounded,
                                                  ),
                                                  onPressed: () {
                                                    gen.passVisible.value =
                                                        !gen.passVisible.value;
                                                  },
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              obscureText:
                                                  gen.passVisible.value,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: gen.scrHeight * 0.025),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Obx(
                                            () => FlutterPwValidator(
                                              controller: sP.newPassEC.value,
                                              minLength: 8,
                                              uppercaseCharCount: 1,
                                              numericCharCount: 2,
                                              specialCharCount: 1,
                                              width: gen.resWidth / 1.5,
                                              height: gen.scrHeight / 6,
                                              successColor:
                                                  Colors.deepPurpleAccent,
                                              onSuccess: () =>
                                                  {gen.pwVal.value = true},
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: gen.scrHeight * 0.025),
                                        SizedBox(
                                          width: gen.resWidth / 1.5,
                                          child: Obx(
                                            () => TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (val) {
                                                if (val !=
                                                    sP.newPassEC.value.text) {
                                                  return "Please make sure passwords match";
                                                } else if (val!.isEmpty) {
                                                  return "Confirm password field cannot be empty";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              focusNode: rP.focus1,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(rP.focus2);
                                              },
                                              controller: sP.conNewPassEC.value,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Confirm New Password',
                                                labelStyle: const TextStyle(),
                                                border:
                                                    const OutlineInputBorder(),
                                                icon: const Icon(
                                                    Icons.lock_rounded),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    gen.passVisible.value
                                                        ? Icons
                                                            .visibility_rounded
                                                        : Icons
                                                            .visibility_off_rounded,
                                                  ),
                                                  onPressed: () {
                                                    gen.passVisible.value =
                                                        !gen.passVisible.value;
                                                  },
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              obscureText:
                                                  gen.passVisible.value,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: gen.scrHeight * 0.035),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: gen.scrHeight * 0.035),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.restart_alt_rounded,
                        ),
                        onPressed: _reset,
                        label: Text(
                          "Reset",
                          style: TextStyle(fontSize: gen.resWidth * 0.035),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(gen.resWidth / 3, gen.scrHeight / 15),
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
    );
  }

  final GeneralController gen = Get.find();
  final ResetPwController rP = Get.put(ResetPwController());

  void _reset() {
    if (!rP.formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please make sure details are complete",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    } else if (gen.pwVal.value != true) {
      Fluttertoast.showToast(
          msg: "Please make sure the password is correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    } else {
      String email = rP.data;

      ProgressDialog progress = ProgressDialog(
        context,
        title: const Text("Reset Password"),
        message: const Text("Updating your new password..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/user/reset_pass.php"),
          body: {
            "email": email,
            "pass": rP.newPassEC.value.text,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Password reset successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
        } else {
          Fluttertoast.showToast(
            msg: "Reset failed. Please try again",
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
