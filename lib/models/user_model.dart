import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String username;
  final String photoUrl;
  final String bio;
  final List followers;
  final List followings;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.followings,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": username,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "followings": followings,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot['uid'],
        email: snapshot['email'],
        username: snapshot['username'],
        photoUrl: snapshot['photoUrl'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        followings: snapshot['followings']);
  }
}
