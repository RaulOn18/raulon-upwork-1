import 'package:dplus/controller/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView_Test extends StatelessWidget {
  const LoginView_Test({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                              // labelText: 'Account',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[100]),
                          controller: loginController.emailEditingController,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              // labelText: 'Password',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[100]),
                          controller: loginController.passwordEditingController,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  color: Colors.grey,
                  width: 300,
                  child: IconButton(
                      onPressed: () {
                        // loginController.createAccount();
                        // loginController.createAccount_bySora();
                      },
                      icon: const Icon(Icons.login)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 120,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text("Don’t have an account? Sign up."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // }
  }
}
