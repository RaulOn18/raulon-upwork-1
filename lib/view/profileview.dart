import 'dart:io';

import 'package:dplus/components/custom_button.dart';
import 'package:dplus/model/login_type.dart';
import 'package:dplus/model/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../controller/profilecontroller.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;
  final currentUser = FirebaseAuth.instance.currentUser;
  DateTime selectedDate = DateTime.now();

  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.idController.text = currentUser?.uid ?? "";
    controller.emailController.text = currentUser?.email ?? "";
  }

  @override
  void dispose() {
    controller.emailController.dispose();
    // logout
    FirebaseAuth.instance.signOut();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Setup Your Profile'),
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.getImage(ImageSource.gallery);
                          },
                          child: Obx(
                            () => ClipOval(
                              child: controller.image == null
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Image.file(
                                      controller.image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tap to set profile image',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ],
                    ),

                    // 이름
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: "이름",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "이름을 입력하세요.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // ID
                    TextFormField(
                      controller: controller.idController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "ID (Read only)",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ID를 입력하세요.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Email
                    TextFormField(
                      controller: controller.emailController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Email (Read only)",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email을 입력하세요.";
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9.!#<span class="math-inline">%&’\*\+/\=?^\_\`\{\|\}\~\-\]\+@\[a\-zA\-Z0\-9\-\]\+\(?\:\\\.\[a\-zA\-Z0\-9\-\]\+\)\*</span>')
                            .hasMatch(value)) {
                          return "유효한 이메일 주소가 아닙니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // 사진 URL
                    TextFormField(
                      controller: controller.photoController,
                      decoration: const InputDecoration(
                        labelText: "사진 URL",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "사진 URL을 입력하세요.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // 생년월일
                    TextFormField(
                      controller: controller.dobController,
                      decoration: const InputDecoration(
                        labelText: "생년월일 (ddMMyyyy)",
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                        controller.dobController.text =
                            DateFormat("dd-MMM-yyyy")
                                .format(selectedDate)
                                .toString();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "생년월일을 입력하세요.";
                        } else if (value.length != 8 ||
                            !RegExp(r'^[0-9]{8}$').hasMatch(value)) {
                          return "유효한 생년월일 형식이 아닙니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // 국적
                    TextFormField(
                      controller: controller.nationalityController,
                      decoration: const InputDecoration(
                        labelText: "국적",
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 위치
                    TextFormField(
                      controller: controller.locationController,
                      decoration: const InputDecoration(
                        labelText: "위치",
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 피닉스 레이팅
                    Obx(
                      () => DropdownButtonFormField<String>(
                        items:
                            List<String>.generate(30, (i) => (i + 1).toString())
                                .map((value) => DropdownMenuItem(
                                    value: value, child: Text(value)))
                                .toList(),
                        value: controller.phoenixRating.value,
                        onChanged: (value) {
                          controller.updatePhoenixRating(value!);
                        },
                        decoration: const InputDecoration(
                          labelText: "피닉스 레이팅",
                        ),
                      ),
                    ),
                    // 피닉스 레이팅
                    Obx(
                      () => DropdownButtonFormField<String>(
                        items:
                            List<String>.generate(30, (i) => (i + 1).toString())
                                .map((value) => DropdownMenuItem(
                                    value: value, child: Text(value)))
                                .toList(),
                        value: controller.dartLiveRating.value,
                        onChanged: (value) {
                          controller.updateDartLiveRating(value!);
                        },
                        decoration: const InputDecoration(
                          labelText: "다트라이브 셋팅",
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: controller.barrelController,
                      decoration: const InputDecoration(
                        labelText: "배럴",
                      ),
                    ),
                    TextFormField(
                      controller: controller.flightController,
                      decoration: const InputDecoration(
                        labelText: "플라이트",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.shaftController,
                      decoration: const InputDecoration(
                        labelText: "샤프트",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.tipController,
                      decoration: const InputDecoration(
                        labelText: "팁",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.favoriteDartsPlayersController,
                      decoration: const InputDecoration(
                        labelText: "최애 다트 선수",
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 50,
                      child: CustomButton(
                        onPressed: () async {
                          try {
                            MyUser user = MyUser(
                              uid: currentUser!.uid,
                              name: controller.nameController.text,
                              id: controller.idController.text,
                              email: controller.emailController.text,
                              photo: controller.photoController.text,
                              dob: controller.dobController.text,
                              nationality:
                                  controller.nationalityController.text,
                              location: controller.locationController.text,
                              phoenixRating: controller.phoenixRating.value,
                              dartLiveRating: controller.dartLiveRating.value,
                              mydartsetting: DartSetting(
                                barrel: controller.barrelController.text,
                                shaft: controller.shaftController.text,
                                plate: controller.flightController.text,
                                tip: controller.tipController.text,
                              ),
                              favoriteDartsPlayers: [
                                controller.favoriteDartsPlayersController.text
                              ],
                              loginType: LoginType.na,
                              isProfileSetup: true,
                              language: "English/en",
                              timestamp: DateTime.now().millisecondsSinceEpoch,
                            );

                            await controller.updateProfileUser(user);
                          } catch (e) {
                            print(e);
                          }
                        },
                        text: "저장",
                        isExpand: true,
                      ),
                    )
                    // InkWell(
                    //     onTap: () {
                    //       Get.to(() => const MyHomePage(
                    //             title: '',
                    //           ));

                    //       // final current_time =
                    //       //     DateTime.now().millisecondsSinceEpoch;

                    //       // // 사용자 정보를 생성합니다.
                    //       // MyUser profileData = MyUser(
                    //       //   uid: "testUID",
                    //       //   loginType: LoginType.na,
                    //       //   language: "English/en", //TODO LANGUAGE option?
                    //       //   isProfileSetup: true,
                    //       //   timestamp: current_time,
                    //       //   name: controller.nameController.text,
                    //       //   id: controller.idController.text,
                    //       //   email: controller.emailController.text,
                    //       //   photo: controller.photoController.text,
                    //       //   dob: controller.dobController.text,
                    //       //   nationality: controller.nationalityController.text,
                    //       //   location: controller.locationController.text,
                    //       //   phoenixRating: controller.phoenixRating.value,
                    //       //   dartLiveRating: controller.dartLiveRating.value,
                    //       //   favoriteDartsPlayers: controller
                    //       //       .favoriteDartsPlayersController.text
                    //       //       .split(","),
                    //       //   mydartsetting: DartSetting(
                    //       //     plate: controller.flightController.text,
                    //       //     shaft: controller.shaftController.text,
                    //       //     tip: controller.tipController.text,
                    //       //     barrel: controller.barrelController.text,
                    //       //   ),
                    //       // );
                    //     },

                    // ),
                  ]),
                ),
              )),
        ));
  }
}
