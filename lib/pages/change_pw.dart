import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../model/config.dart';
import '../model/controller.dart';

void main() => runApp(const ChangePw());

class ChangePw extends StatefulWidget {
  const ChangePw({Key? key}) : super(key: key);

  @override
  State<ChangePw> createState() => _ChangePwState();
}

class _ChangePwState extends State<ChangePw> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final ChangePwController cP = Get.put(ChangePwController());

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
        title: const Text('Edit'),
      ),
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
                        "Update Password",
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
                            key: cP.formKey,
                            child: SizedBox(
                              width: gen.resWidth,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                              height: gen.scrHeight * 0.025),
                                          SizedBox(
                                            width: gen.resWidth / 1.5,
                                            child: Obx(
                                              () => TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (val) => val!.isEmpty
                                                    ? "Old password field cannot be empty"
                                                    : null,
                                                focusNode: cP.focus,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(cP.focus1);
                                                },
                                                controller: cP.oldPassEC.value,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Enter Old Password',
                                                  labelStyle: const TextStyle(),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  icon: const Icon(
                                                      Icons.lock_open_rounded),
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
                                                          !gen.passVisible
                                                              .value;
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
                                          SizedBox(
                                              height: gen.scrHeight * 0.025),
                                          SizedBox(
                                            width: gen.resWidth / 1.5,
                                            child: Obx(
                                              () => TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (val) => val!.isEmpty
                                                    ? "New password field cannot be empty"
                                                    : null,
                                                focusNode: cP.focus1,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(cP.focus2);
                                                },
                                                controller: cP.newPassEC.value,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Enter New Password',
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
                                                          !gen.passVisible
                                                              .value;
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
                                          SizedBox(
                                              height: gen.scrHeight * 0.025),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Obx(
                                              () => FlutterPwValidator(
                                                controller: cP.newPassEC.value,
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
                                          SizedBox(
                                              height: gen.scrHeight * 0.025),
                                          SizedBox(
                                            width: gen.resWidth / 1.5,
                                            child: Obx(
                                              () => TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (val) {
                                                  if (val !=
                                                      cP.newPassEC.value.text) {
                                                    return "Please make sure passwords match";
                                                  } else if (val!.isEmpty) {
                                                    return "Confirm password field cannot be empty";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                focusNode: cP.focus2,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(cP.focus3);
                                                },
                                                controller:
                                                    cP.conNewPassEC.value,
                                                keyboardType:
                                                    TextInputType.text,
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
                                                          !gen.passVisible
                                                              .value;
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
                      ),
                      SizedBox(height: gen.scrHeight * 0.035),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.note_alt_rounded,
                        ),
                        onPressed: _update,
                        label: Text(
                          "Update",
                          style: TextStyle(fontSize: gen.resWidth * 0.035),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(gen.scrWidth / 3, gen.scrHeight / 15),
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
  final ChangePwController cP = Get.put(ChangePwController());
  final MainPageController mp = Get.find();

  _update() {
    if (!cP.formKey.currentState!.validate()) {
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
      ProgressDialog progress = ProgressDialog(
        context,
        title: const Text("Edit Profile"),
        message: const Text("Updating your password..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/user/edit_pass.php"),
          body: {
            "id": mp.userDet.id,
            "old_pass": cP.oldPassEC.value.text,
            "new_pass": cP.newPassEC.value.text,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Password updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
        } else {
          Fluttertoast.showToast(
            msg: "Update failed. Please try again",
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
