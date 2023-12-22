import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dplus/components/custom_button.dart';
import 'package:dplus/controller/feedcontroller.dart';
import 'package:dplus/model/feed_model.dart';
import 'package:dplus/service/userUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFeedView extends StatefulWidget {
  const AddFeedView({super.key});

  @override
  State<AddFeedView> createState() => _AddFeedViewState();
}

class _AddFeedViewState extends State<AddFeedView> {
  final FeedController feedController = Get.put(FeedController());

  String modeValue = "public";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Feed",
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.close), onPressed: () => Get.back()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                hint: const Text("Select Feed Type"),
                dropdownColor: const Color(0xff262626),
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                value: modeValue,
                items: [
                  DropdownMenuItem(
                    value: "public",
                    child: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public, size: 20),
                          Text(
                            "Public",
                          )
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "private",
                    child: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock, size: 20),
                          Text(
                            "Private",
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    modeValue = value!;
                  });
                  print(value);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: feedController.contentEditingController,
                  maxLines: 10, //or null
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your text here",
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            CustomButton(
              onPressed: () {
                Feed newFeed = Feed(
                  uidFeed: UserUtil().getCurrentUser()!.uid,
                  image: "image",
                  writer: UserUtil().getCurrentUser()!.name,
                  content: feedController.contentEditingController.text,
                  lastUpdatedTime: Timestamp.now(),
                  comments: [],
                  likes: [],
                );
                feedController.createFeed(newFeed);
              },
              text: "Post",
              isExpand: true,
            )
          ],
        ),
      ),
    );
  }
}
