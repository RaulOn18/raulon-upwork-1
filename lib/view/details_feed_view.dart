import 'package:dplus/components/custom_pop_up_menu.dart';
import 'package:dplus/view/edit_feed_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsFeedView extends StatefulWidget {
  const DetailsFeedView({super.key});

  @override
  State<DetailsFeedView> createState() => _DetailsFeedViewState();
}

class _DetailsFeedViewState extends State<DetailsFeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details Feed",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            Card(
              elevation: 0.6,
              color: Colors.white,
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, top: 10, bottom: 10),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Radja Fajrul Ghufron",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CustomPopUpMenu(
                        color: const Color(0xff262626),
                        onSelected: (value) {
                          switch (value) {
                            case "삭제":
                              break;
                            case "수정":
                              Get.to(() => const EditFeedView());
                              break;
                            default:
                          }
                        },
                        items: [
                          PopupMenuItem(
                            onTap: () {},
                            value: "삭제",
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete,
                                      color: Colors.red, size: 20),
                                  Text(
                                    "삭제",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: "수정",
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  Text(
                                    "수정",
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "CONTENTS CONTENTS CONTENTS CONTENTS CONTENTS CONTENTS CONTENTS CONTENTS",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
              child: Text(
                "Comments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Card(
              elevation: 0.6,
              color: Colors.white,
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, top: 10, bottom: 10),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Radja Fajrul Ghufron",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Your feed is really cool, very inspiring, and motivates me to do good all the time.',
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      CustomPopUpMenu(
                        color: const Color(0xff262626),
                        onSelected: (value) {
                          switch (value) {
                            case "삭제":
                              break;
                            case "수정":
                              break;
                            default:
                          }
                        },
                        items: [
                          PopupMenuItem(
                            onTap: () {},
                            value: "삭제",
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete,
                                      color: Colors.red, size: 20),
                                  Text(
                                    "삭제",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: "수정",
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  Text(
                                    "수정",
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
