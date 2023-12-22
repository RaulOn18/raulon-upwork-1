# dplus

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 테스트시 - 프로필 셋업페이지 스킵하는 법.

afterLogin() {
Get.to(() => UserUtil().getCurrentUser().isProfileSetup
? const MyHomePage(
title: '',
)
: ProfilePage());
}

를 아래로 변경
afterLogin() {
Get.to(() => ProfilePage());
}
