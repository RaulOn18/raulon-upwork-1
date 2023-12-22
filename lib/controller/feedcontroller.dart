import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dplus/model/feed_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  TextEditingController contentEditingController = TextEditingController();
  TextEditingController typeContentController = TextEditingController();

  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final dbPathFeed = "Feeds";
  Future<List<Feed>> getAllFeedsWithCommentsAndLikes() async {
    final currentUser = auth.currentUser;
    print("currentUser :${currentUser}");
    try {
      List<Feed> dataAllFeeds = [];
      final feedRef = db.collection(dbPathFeed);
      final feedSnapshot = await feedRef.get();

      for (var feedDoc in feedSnapshot.docs) {
        // Create a Feed object from the main document
        var feed = Feed.fromFireStore(feedDoc);

        // Get comments subcollection for the current feed
        final commentsRef = feedRef.doc(feedDoc.id).collection('Comments');
        final commentsSnapshot = await commentsRef.get();
        for (var commentDoc in commentsSnapshot.docs) {
          feed.comments!.add(Comments.fromFirestore(commentDoc.data()));
        }

        // Get likes subcollection for the current feed
        final likesRef = feedRef.doc(feedDoc.id).collection('Like');
        final likesSnapshot = await likesRef.get();
        for (var likeDoc in likesSnapshot.docs) {
          feed.likes!.add(Like.fromFirestore(likeDoc.data()));
        }

        dataAllFeeds.add(feed);
      }

      return dataAllFeeds;
    } catch (e) {
      print("Error getting documents: $e");
      throw e;
    }
  }

  // create Feed
  Future<void> createFeed(Feed feed) async {
    final feedRef = db.collection(dbPathFeed);

    await feedRef.add(feed.toMap());
  }

  Future<void> deletedFeed(String uidFeed) async {
    final feedRef = db.collection(dbPathFeed);

    await feedRef.doc(uidFeed).delete();
  }
}
