import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String username;
  final String uid;
  final likes;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;

  const Post({
    required this.description,
    required this.username,
    required this.uid,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    // required this.following
  });

  Map<String, dynamic> toJson() =>
      {
        'description': description,
        'username': username,
        'uid': uid,
        'likes': likes,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot['description'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
    );
  }
}
