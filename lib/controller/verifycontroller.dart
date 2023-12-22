import 'dart:async';
import 'package:dplus/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isEmailVerified = false.obs;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.to(() => const MyHomePage(title: ''));
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  void resendVerificationEmail() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user.sendEmailVerification();
        // Email sent.
        print('Email verification sent');
      } catch (error) {
        // An error occurred.
        print('Error sending email verification: $error');
      }
    } else {
      print('No user signed in.');
    }
  }
}
