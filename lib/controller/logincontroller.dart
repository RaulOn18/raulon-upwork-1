import 'dart:async';
import 'package:dplus/main.dart';
import 'package:dplus/service/userUtil.dart';
import 'package:dplus/view/login/loginview.dart';
import 'package:dplus/view/login/verifyEmailView.dart';
import 'package:dplus/view/profileview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  final db = FirebaseFirestore.instance;
  final current_time = DateTime.now().millisecondsSinceEpoch;

  bool isEmailVerified = false;

  login() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );
      final currentUser = FirebaseAuth.instance.currentUser;
      prefs.setString("loginType", "na");
      afterLogin();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  createAccount_bySora() async {
    try {
      var emailAddress = emailEditingController.value.text;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: passwordEditingController.value.text,
      );

      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && !currentUser.emailVerified) {
        await currentUser.sendEmailVerification();
        Get.to(() => VerifyEmailView());
      }
      print("complete create account");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        if (UserUtil().getCurrentUser()?.isProfileSetup ?? false) {
          login();
        }
        Get.to(() => const MyHomePage(title: "D+"));
      }
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null &&
          !FirebaseAuth.instance.currentUser!.emailVerified) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
      print(e);
    }
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => {afterLogin()});
  }

  Future<void> signInWithKakao() async {
    // 카카오톡 실행 가능 여부 확인
// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await kakao.isKakaoTalkInstalled()) {
      try {
        print('카카오톡으로 로그인 성공');
        await kakao.UserApi.instance
            .loginWithKakaoTalk()
            .then((value) => afterLogin());
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await kakao.UserApi.instance
              .loginWithKakaoAccount()
              .then((value) => afterLogin());
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await kakao.UserApi.instance
            .loginWithKakaoAccount()
            .then((value) => afterLogin());
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  void signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    await FirebaseAuth.instance
        .signInWithProvider(appleProvider)
        .then((value) => afterLogin());
  }

  afterLogin() {
    Get.to(() => UserUtil().getCurrentUser()?.isProfileSetup ?? false
        ? const MyHomePage(
            title: '',
          )
        : ProfileView());
  }

  // afterLogin() {
  //   Get.to(() => UserUtil().getCurrentUser().isProfileSetup
  //       ? const MyHomePage(
  //           title: '',
  //         )
  //       : ProfileView());
  // }

  signOut() async {
    // log out
    await FirebaseAuth.instance.signOut();
    try {
      Get.to(() => LoginView());
      await kakao.UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }
}
