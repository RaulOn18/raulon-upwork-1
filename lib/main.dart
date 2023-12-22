import 'package:dplus/firebase_options.dart';
import 'package:dplus/service/userUtil.dart';
import 'package:dplus/view/login/loginview.dart';
import 'package:dplus/view/friendsview.dart';
import 'package:dplus/view/homeview.dart';
import 'package:dplus/view/settingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart'
    as kakao_flutter_sdk_user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hiding for testing
  kakao_flutter_sdk_user.KakaoSdk.init(
    nativeAppKey: '244406bb8a874cdb7e692c3459e6c0c6',
    javaScriptAppKey: 'd8101f01db87a3dec56acc471ff332cd',
  );

  bool isLoggedIn = await UserUtil().checkIfAlreadyLoggedIn();

  runApp(
    MyApp(
      isLogin: isLoggedIn,
    ),
  );
}

class MyApp extends StatelessWidget {
  bool isLogin = true;

  MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),

      //TODO isLogin go to profile page.
      home: (isLogin) ? const MyHomePage(title: '') : LoginView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _bottomNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeView(),
          //WorldWideChatView(),
          const FriendsView(),
          SettingView(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.connect_without_contact_outlined),
            //     label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_sharp), label: "Friends"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Setting"),
          ],
          currentIndex: _selectedIndex,
          onTap: _bottomNavigation,
          // selectedItemColor: Theme.of(context).primaryColor
        ),
      ),
    );
  }
}
