import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String username;
  final String email;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const PostModel({
    required this.description,
    required this.uid,
    required this.username,
    required this.email,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "email": email,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "likes": likes,
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      description: snapshot['description'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
    );
  }
}
