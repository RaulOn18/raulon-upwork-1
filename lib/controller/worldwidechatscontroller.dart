import 'dart:async';
import 'dart:io';
import 'package:dplus/controller/myUserController.dart';
import 'package:dplus/model/dplusmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translator/translator.dart';

class WorldwideChatsController extends GetxController {
  TextEditingController chatEditingController = TextEditingController();
  MyUserController myUserController = Get.put(MyUserController());
}
