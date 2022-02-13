import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/controller.dart';
import 'edit_profile.dart';
import 'login.dart';

void main() => runApp(const Profile());

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final GeneralController gen = Get.find();
    final ProfileController prof = Get.put(ProfileController());
    final MainPageController mp = Get.put(MainPageController());
    Get.lazyPut(() => LoginController());

    gen.scrHeight = MediaQuery.of(context).size.height;
    gen.scrWidth = MediaQuery.of(context).size.width;

    if (gen.scrWidth <= 600) {
      gen.resWidth = gen.scrWidth;
    } else {
      gen.resWidth = gen.scrWidth * 0.75;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 229, 248),
      body: mp.userDet.id == "NA"
          ? const Login()
          : Center(
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
                                "My Profile",
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
                                  child: SizedBox(
                                    width: gen.resWidth,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons
                                                    .supervised_user_circle_rounded,
                                                color: Colors.purple),
                                            SizedBox(
                                                width: gen.resWidth * 0.035),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Name',
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      mp.userDet.name,
                                                      style: TextStyle(
                                                        fontSize: gen.resWidth *
                                                            0.045,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            SizedBox(
                                                width: gen.resWidth * 0.035),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Email',
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      mp.userDet.email,
                                                      style: TextStyle(
                                                        fontSize: gen.resWidth *
                                                            0.045,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            SizedBox(
                                                width: gen.resWidth * 0.035),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Phone No.',
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      mp.userDet.phone,
                                                      style: TextStyle(
                                                        fontSize: gen.resWidth *
                                                            0.045,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            const Icon(Icons.home_rounded,
                                                color: Colors.purple),
                                            SizedBox(
                                                width: gen.resWidth * 0.035),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Address',
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      mp.userDet.address,
                                                      style: TextStyle(
                                                        fontSize: gen.resWidth *
                                                            0.045,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            const Icon(
                                                Icons.verified_user_rounded,
                                                color: Colors.purple),
                                            SizedBox(
                                                width: gen.resWidth * 0.035),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Account Status',
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: mp.userDet.status ==
                                                            "Unverified"
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                mp.userDet
                                                                    .status,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      gen.resWidth *
                                                                          0.045,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      gen.resWidth *
                                                                          0.035),
                                                              OutlinedButton(
                                                                  onPressed: prof
                                                                      .verify,
                                                                  child: const Text(
                                                                      "Verify Account"),
                                                                  style: OutlinedButton
                                                                      .styleFrom(
                                                                    shape:
                                                                        const StadiumBorder(),
                                                                  )),
                                                            ],
                                                          )
                                                        : Text(
                                                            mp.userDet.status,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  gen.resWidth *
                                                                      0.045,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.teal,
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                                      Icons.edit_rounded,
                                    ),
                                    onPressed: () {
                                      Get.to(
                                        () => const EditProfile(),
                                      );
                                    },
                                    label: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: gen.resWidth * 0.035),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                          gen.resWidth / 3, gen.scrHeight / 15),
                                    ),
                                  ),
                                  SizedBox(width: gen.resWidth * 0.025),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.logout_rounded,
                                    ),
                                    onPressed: prof.logout,
                                    label: Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontSize: gen.resWidth * 0.035),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                          gen.resWidth / 3, gen.scrHeight / 15),
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
}
