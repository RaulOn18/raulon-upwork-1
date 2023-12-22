import 'package:dplus/controller/myUserController.dart';
import 'package:dplus/model/login_type.dart';
import 'package:dplus/model/myUser.dart';
import 'package:dplus/view/login/loginview.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart'
    as kakao_auth;

import 'package:cloud_firestore/cloud_firestore.dart';

class UserUtil {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final dbPathUser = "Users";
  String userEmail = "";

  final dbPatChat = "Chats";
  String docWorld = "WorldChat";

  MyUser? getCurrentUser() {
    Get.put<MyUserController>(MyUserController());
    return Get.find<MyUserController>().getUser();
  }

  bool checkUserLogin() {
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user);
      return true;
    } else {
      return false;
    }
  }

  Future<MyUser> getUserData(String uid) async {
    try {
      Get.put<MyUserController>(MyUserController());

      final docRef = db.collection(dbPathUser).doc(uid);
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        MyUser user = MyUser.fromFirestore(doc.id, data);
        Get.find<MyUserController>().setUser(user);
        print(
            "Get.find<MyUserController>().user.value : ${Get.find<MyUserController>().user.value!.language}");
        return user;
      } else {
        //need to set up profile
        MyUser user = MyUser.createfirstTimeUser(uid, userEmail);
        saveUserInformation(user);
        Get.find<MyUserController>().setUser(user);

        return user;
      }
    } catch (e) {
      print("Error getting document: $e");
      rethrow;
    }
  }

  void saveUserInformation(MyUser user) async {
    final docRef = db.collection(dbPathUser).doc(user.uid);
    final chatdocRef = db.collection(dbPatChat).doc(docWorld);
    final DocumentReference documentReference = chatdocRef;

    await documentReference.update({
      'world_users': FieldValue.arrayUnion([user.email]),
    });

    try {
      await docRef.set(user.toMap());
      print('User information saved successfully.');
    } catch (e) {
      print('Error saving user information: $e');
    }
  }

  Future<bool> checkIfAlreadyLoggedIn() async {
    String userId = _checkFirebaseUser();

    if (userId.isEmpty) {
      userId = await _checkKakaoLogin();
    }

    if (userId.isNotEmpty) {
      getUserData(userId);
    }

    return userId.isNotEmpty; //get userdata and save in cache.
  }

  Future<String> _checkKakaoLogin() async {
    try {
      kakao_auth.User user = await kakao_auth.UserApi.instance.me();
      userEmail = user.kakaoAccount?.email ?? "";

      print('Succeeded in retrieving user information.'
          '\nService user ID: ${user.id}'
          '\nLinked status:: ${user.hasSignedUp}');
      return user.id.toString();
    } catch (error) {
      print('Failed to retrieve user information. $error');
      return "";
    }
  }

  String _checkFirebaseUser() {
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;

    userEmail = user?.email ?? "";
    return user != null ? user.uid : "";
  }

  LoginType parseLoginType(String? loginTypeString) {
    return loginTypeString != null
        ? LoginType.values.firstWhere(
            (type) => type.toString().split('.')[1] == loginTypeString,
            orElse: () => LoginType.email,
          )
        : LoginType.email;
  }
}
