import 'package:dplus/components/custom_pop_up_menu.dart';
import 'package:dplus/controller/feedcontroller.dart';
import 'package:dplus/controller/logincontroller.dart';
import 'package:dplus/service/userUtil.dart';
import 'package:dplus/view/add_feed_view.dart';
import 'package:dplus/view/details_feed_view.dart';
import 'package:dplus/view/edit_feed_view.dart';
import 'package:dplus/view/login/loginview.dart';
import 'package:dplus/view/profileview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FeedController feedController = Get.put(FeedController());
  LoginController loginController = Get.put(LoginController());

  Future<void> getAllFeeds() {
    try {
      return feedController.getAllFeedsWithCommentsAndLikes();
    } catch (e) {
      print("Error getting documents: $e");
      rethrow;
    }
  }

  @override
  void initState() {
    getAllFeeds();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => {Get.to(() => LoginView())});
            },
          ),
        ],
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            FutureBuilder(
                future: feedController.getAllFeedsWithCommentsAndLikes(),
                builder: (builder, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          // print("snapshot ${snapshot.data![index].comments}");
                          return InkWell(
                            onTap: () => Get.to(() => const DetailsFeedView()),
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              color: Colors.white,
                              elevation: 0.6,
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        snapshot.data![index].writer,
                                        style: const TextStyle(
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
                                              feedController.deletedFeed(
                                                  snapshot
                                                      .data![index].uidFeed);
                                              break;
                                            case "수정":
                                              Get.to(
                                                  () => const EditFeedView());
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
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.white,
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.delete,
                                                      color: Colors.red,
                                                      size: 20),
                                                  Text(
                                                    "삭제",
                                                    style: TextStyle(
                                                        color: Colors.red),
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
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.white,
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                  Text(
                                    snapshot.data![index].content,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite),
                                    ),
                                    Text(
                                      snapshot.data![index].likes!.length
                                          .toString(),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: const Icon(Icons.comment),
                                    ),
                                    Text(
                                      snapshot.data![index].comments!.length
                                          .toString(),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => const DetailsFeedView());
                                      },
                                      child: const Text(
                                        "전체보기",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ])
                                ]),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (UserUtil().checkUserLogin()) {
            Get.to(() => const AddFeedView());
          } else {
            print("KAMU BELUM LOGIN");
            showPopupCard(
              context: context,
              builder: (context) {
                return PopupCard(
                  elevation: 8,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.lock,
                              size: 32,
                              color: Colors.red,
                            ),
                            const Text(
                              "Setup Account Required",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Your account must be setup first",
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff262626),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                loginController.login();
                                // Get.to(() => ProfileView());
                              },
                              child: const Text(
                                "Setup account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            );
          }
        },
        tooltip: 'Create Feed',
        child: const Icon(Icons.rate_review_outlined),
      ),
    );
  }
}
