import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../model/config.dart';
import '../model/controller.dart';
import '../model/user.dart';
import 'change_pw.dart';
import 'main_page.dart';

void main() => runApp(const EditProfile());

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final EditProfileController eP = Get.put(EditProfileController());

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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "Edit Profile Details",
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
                              key: eP.formKey,
                              child: SizedBox(
                                width: gen.resWidth,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  validator: (val) => val!
                                                              .isEmpty ||
                                                          (val.length < 5)
                                                      ? "Name must be longer than 5 characters"
                                                      : null,
                                                  focusNode: eP.focus,
                                                  onFieldSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            eP.focus1);
                                                  },
                                                  controller: eP.nameEC.value,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Name',
                                                    labelStyle: TextStyle(),
                                                    border:
                                                        OutlineInputBorder(),
                                                    icon: Icon(Icons
                                                        .supervised_user_circle_rounded),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
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
                                                  validator: (val) => val!
                                                              .isEmpty ||
                                                          !val.contains("@") ||
                                                          !val.contains(".")
                                                      ? "Please enter a valid email"
                                                      : null,
                                                  focusNode: eP.focus1,
                                                  onFieldSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            eP.focus2);
                                                  },
                                                  controller: eP.emailEC.value,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Email',
                                                    labelStyle: TextStyle(),
                                                    border:
                                                        OutlineInputBorder(),
                                                    icon: Icon(
                                                        Icons.email_rounded),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
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
                                                  validator: (val) => (val!
                                                              .isEmpty) ||
                                                          (val.length < 10)
                                                      ? "Please enter a valid phone number"
                                                      : null,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  focusNode: eP.focus2,
                                                  onFieldSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            eP.focus3);
                                                  },
                                                  controller: eP.phoneEC.value,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Phone',
                                                    labelStyle: TextStyle(),
                                                    border:
                                                        OutlineInputBorder(),
                                                    icon: Icon(
                                                        Icons.phone_rounded),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: gen.scrHeight * 0.025),
                                            SizedBox(
                                              width: gen.resWidth / 1.5,
                                              child: Obx(
                                                () => TextFormField(
                                                  maxLines: 5,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  validator: (val) => val!
                                                          .isEmpty
                                                      ? "Address must not be empty"
                                                      : null,
                                                  focusNode: eP.focus3,
                                                  onFieldSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            eP.focus4);
                                                  },
                                                  controller: eP.addEC.value,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Address',
                                                    labelStyle: TextStyle(),
                                                    border:
                                                        OutlineInputBorder(),
                                                    icon: Icon(
                                                        Icons.home_rounded),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: gen.scrHeight * 0.025),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: gen.scrHeight * 0.015),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: gen.scrHeight * 0.035),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.vpn_key_rounded,
                              ),
                              onPressed: () {
                                Get.to(() => const ChangePw());
                              },
                              label: Text(
                                "Change Password",
                                style:
                                    TextStyle(fontSize: gen.resWidth * 0.035),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(gen.resWidth / 3, gen.scrHeight / 15),
                              ),
                            ),
                            SizedBox(width: gen.resWidth * 0.035),
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.note_alt_rounded,
                              ),
                              onPressed: _update,
                              label: Text(
                                "Update",
                                style:
                                    TextStyle(fontSize: gen.resWidth * 0.035),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(gen.resWidth / 3, gen.scrHeight / 15),
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

  final EditProfileController eP = Get.put(EditProfileController());
  final MainPageController mp = Get.find();

  _update() {
    if (!eP.formKey.currentState!.validate()) {
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
        title: const Text("Edit Profile"),
        message: const Text("Updating your account..."),
      );

      progress.show();

      http.post(
          Uri.parse(Config.server + "/dg_homebakery/php/user/edit_profile.php"),
          body: {
            "id": mp.userDet.id,
            "name": eP.nameEC.value.text,
            "email": eP.emailEC.value.text,
            "phone": eP.phoneEC.value.text,
            "address": eP.addEC.value.text,
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          User user = User(
            id: mp.userDet.id,
            name: eP.nameEC.value.text,
            email: eP.emailEC.value.text,
            phone: eP.phoneEC.value.text,
            address: eP.addEC.value.text,
            otp: mp.userDet.otp,
            status: mp.userDet.status,
          );

          Fluttertoast.showToast(
            msg: "Account details updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14,
          );

          progress.dismiss();
          Get.offAll(MainPage(), arguments: user);
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
