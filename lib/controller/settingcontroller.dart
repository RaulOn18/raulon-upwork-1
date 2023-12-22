import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dplus/controller/myUserController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';

class SettingController extends GetxController {
  final db = FirebaseFirestore.instance;
  final _selectedDialogLanguage = Rx<Language>(Languages.english);
  Language get selectedDialogLanguage => _selectedDialogLanguage.value;
  RxList userInfoList = [].obs;
  // MyUserController myUserController = Get.find<MyUserController>();
  MyUserController myUserController = Get.put(MyUserController());


  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8.0),
          Flexible(
              child: Text((language.isoCode == "zh_Hans")
                  ? "(zh-cn)"
                  : (language.isoCode == "zh_Hant")
                      ? "(zh-tw)"
                      : "(${language.isoCode})")),
        ],
      );

  _updateLanguage() async {
    final user = FirebaseAuth.instance.currentUser;
    String n = "";
    String c = "";
    if (_selectedDialogLanguage.value.isoCode == "zh_Hans") {
      n = "Chinese (Simplified)";
      c = "zh-cn";
    } else if (_selectedDialogLanguage.value.isoCode == "zh_Hant") {
      n = "Chinese (Traditional)";
      c = "zh-tw";
    } else {
      n = _selectedDialogLanguage.value.name;
      c = _selectedDialogLanguage.value.isoCode;
    }

    db
        .collection("Users")
        .doc(user!.uid)
        .update({"language": "$n/$c"}).then((value) {
      myUserController.updateLanguage("$n/$c");
    });
  }

  void openLanguagePickerDialog() => showDialog(
        context: Get.overlayContext!,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.purple),
          child: LanguagePickerDialog(
              titlePadding: const EdgeInsets.all(8.0),
              searchCursorColor: Colors.pinkAccent,
              searchInputDecoration: const InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: const Text('Select your language'),
              onValuePicked: (Language language) {
                _selectedDialogLanguage.value = language;

                _updateLanguage();
              },
              itemBuilder: _buildDialogItem),
        ),
      );
}
