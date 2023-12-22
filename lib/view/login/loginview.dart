import 'dart:io';
import 'package:dplus/controller/logincontroller.dart';
import 'package:dplus/model/login_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 100),
            getEmailLoginButton(context),
            const SizedBox(height: 20),
            getGoogleLoginButton(),
            if (Platform.isIOS) getAppleLoginButton(),
            getKakaoLoginButton(),
          ]),
        ));
  }

  Widget getEmailLoginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          SizedBox(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Account',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[100],
              ),
              controller: loginController.emailEditingController,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[100],
              ),
              controller: loginController.passwordEditingController,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              //thing to do
              loginController.createAccount_bySora();
            },
            child: Card(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              elevation: 2,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Login Or Create Your Account",
                          style: TextStyle(color: Colors.white, fontSize: 17))
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getGoogleLoginButton() {
    return _getLoginButton(loginController.signInWithGoogle, LoginType.google);
  }

  Map<LoginType, Color> _getLoginButtonColors() {
    return {
      LoginType.google: Colors.white,
      LoginType.apple: Colors.black,
      LoginType.kakao: const Color(0xFFFEE500),
    };
  }

  Map<LoginType, String> _getLoginButtonTexts() {
    return {
      LoginType.google: "Google",
      LoginType.apple: "Apple",
      LoginType.kakao: "Kakao",
    };
  }

  _getLoginButton(onTapFunction, loginType) {
    final colors = _getLoginButtonColors();
    final text = _getLoginButtonTexts();

    return InkWell(
      onTap: onTapFunction,
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: 2,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: colors[loginType],
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('images/${text[loginType]!.toLowerCase()}.png',
                height: 30),
            const SizedBox(
              width: 10,
            ),
            Text("Sign In With ${text[loginType]}",
                style: TextStyle(
                    color: colors[loginType] == Colors.black
                        ? Colors.white
                        : Colors.black,
                    fontSize: 17))
          ]),
        ),
      ),
    );
  }

  Widget getKakaoLoginButton() {
    return _getLoginButton(loginController.signInWithKakao, LoginType.kakao);
  }

  Widget getAppleLoginButton() {
    return _getLoginButton(loginController.signInWithApple, LoginType.apple);
  }
}
