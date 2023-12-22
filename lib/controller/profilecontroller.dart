import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dplus/model/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final photoController = TextEditingController();
  final dobController = TextEditingController();
  final nationalityController = TextEditingController();
  final locationController = TextEditingController();
  final flightController = TextEditingController();
  final shaftController = TextEditingController();
  final barrelController = TextEditingController();

  final tipController = TextEditingController();
  final favoriteDartsPlayersController = TextEditingController();

  final phoenixRating = "1".obs;
  final dartLiveRating = "1".obs;

  void updatePhoenixRating(String value) {
    phoenixRating.value = value;
    update(); // Notify UI about the change in phoenixRating
  }

  void updateDartLiveRating(String value) {
    dartLiveRating.value = value;
    update(); // Notify UI about the change in dartLiveRating
  }

  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfileUser(MyUser? dataUser) async {
    print(dataUser!.toMap());
  }
}
