import 'package:get/get.dart';

import '../model/myUser.dart';

class MyUserController extends GetxController {
  Rx<MyUser?> user = Rx<MyUser?>(null);

  setUser(MyUser newUser) {
    user.value = newUser;
  }

  MyUser? getUser() {
    return user.value;
  }

  updateLanguage(String language) {
    if (user.value != null) {
      user.value!.language = language;
      // Getx controller에서 지정해줌. Getx controller에서만 쓸 수 있는 함수임.
      update(["language"]);
    } else {
      print("user is null.");
    }
  }
}
