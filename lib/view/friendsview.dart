import 'package:flutter/material.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Friends",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
    );
  }
}
