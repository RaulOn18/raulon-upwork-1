import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  final String uidFeed;
  final String image;
  final String writer;
  final String content;
  final List<Like>? likes;
  final List<Comments>? comments;
  final Timestamp lastUpdatedTime;

  Feed({
    required this.uidFeed,
    required this.image,
    required this.writer,
    required this.content,
    required this.lastUpdatedTime,
    this.comments,
    this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'uidFeed': uidFeed,
      'image': image,
      'writer': writer,
      'content': content,
      'lastUpdatedTime': lastUpdatedTime,
      // You may choose to store the comments and likes differently
      // depending on your Firestore structure
      'comments': comments,
      'likes': likes,
    };
  }

  factory Feed.fromFireStore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Feed(
      uidFeed: data['uidFeed'],
      image: data['image'],
      writer: data['writer'],
      content: data['content'],
      comments: data['comments'] != null
          ? List<Comments>.from(
              data['comments'].map((x) => Comments.fromFirestore(x)))
          : [],
      likes: data['likes'] != null
          ? List<Like>.from(data['likes'].map((x) => Like.fromFirestore(x)))
          : [],
      lastUpdatedTime: data['lastUpdatedTime'],
    );
  }
}

class Comments {
  // Define the structure of your Comment class
  final String writer;
  final String image;
  final String content;
  final Timestamp time;
  Comments({
    required this.writer,
    required this.image,
    required this.content,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    // Return a map representation of the comment
    return {
      'writer': writer,
      'image': image,
      'content': content,
      'time': time,
    };
  }

  factory Comments.fromFirestore(Map<String, dynamic> data) {
    return Comments(
      writer: data['writer'],
      image: data['image'],
      content: data['content'],
      time: data['time'],
    );
  }
}

class Like {
  // Define the structure of your Like class
  final String name;
  final String image;
  final Timestamp time;
  final Timestamp lastUpdatedTime;

  Like({
    required this.name,
    required this.image,
    required this.time,
    required this.lastUpdatedTime,
  });
  Map<String, dynamic> toMap() {
    // Return a map representation of the like
    return {
      'name': name,
      'image': image,
      'time': time,
      'lastUpdatedTime': lastUpdatedTime,
    };
  }

  factory Like.fromFirestore(Map<String, dynamic> data) {
    return Like(
      name: data['name'],
      image: data['image'],
      time: data['time'],
      lastUpdatedTime: data['lastUpdatedTime'],
    );
  }
}
