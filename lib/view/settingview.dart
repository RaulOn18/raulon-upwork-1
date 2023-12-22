import 'package:dplus/controller/logincontroller.dart';
import 'package:dplus/controller/myUserController.dart';
import 'package:dplus/controller/settingcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  LoginController loginController = Get.put(LoginController());
  SettingController settingController = Get.put(SettingController());
  MyUserController myUserController = Get.find<MyUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: const Alignment(-0.9, 0), // x, y axis is default
              child: const Text("Translation"),
            ),
            GetBuilder<MyUserController>(
              // Getx 변수 값 컨트롤 됨. 겟빌더 써서 아이디 지정해주면 겟빌더를 사용하는 컨트롤에서 다이렉트로 아이디 감지
              id: "language",
              builder: (controller) {
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Preferred Language"),
                        trailing: Text(
                            controller.user.value?.language
                                    .toString()
                                    .split("/")[0] ??
                                "English/en",
                            style: const TextStyle(fontSize: 15)),
                        onTap: () {
                          settingController.openLanguagePickerDialog();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: const Alignment(-0.9, 0),
              child: const Text("Sign Out"),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 8.0, 10, 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                color: Colors.grey,
                width: 500,
                child: IconButton(
                    onPressed: () {
                      loginController.signOut();
                    },
                    icon: const Icon(Icons.exit_to_app_outlined)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
