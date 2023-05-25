import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
    String descripton,
    Uint8List file,
    String uid,
    String email,
    String username,
    String profileImage,
  ) async {
    String result = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      PostModel post = PostModel(
        description: descripton,
        uid: uid,
        email: email,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profileImage: profileImage,
        likes: [],
      );

      _firestore
          .collection('posts')
          .doc(postId)
          .set(post.toJson()); // convert it to map i.e, toJson()
      // successfully posted
      result = "success";
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      // We can do the method as well but we have to update for all
      // if (likes.contains(uid)) {
      //   _firestore.collection('posts').doc('postId').set({
      //     'likes': FieldValue.arrayRemove([uid]),
      //   });
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComments(String postId, String text, String name, String uid,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          // we can use model either for better
          "profilePic": profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print("The field is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Deleting Post
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  // Following and Followers
  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['followings'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'followings': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followiers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'followings': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
