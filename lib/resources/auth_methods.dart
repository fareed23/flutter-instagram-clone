import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // method -> to get the user details for eg. profile
  Future<UserModel> getUserDetails() async {
    // User provided by Firebase
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return UserModel.fromSnap(snapshot);
  }

  // method -> sign up user
  Future<String> signupUser({
    required String email,
    required String username,
    required String bio,
    required String password,
    required Uint8List file,
  }) async {
    // register the user
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty) {
        // sign in the user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // we use the storage class here
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add the user details in our database
        UserModel userModel = UserModel(
          uid: credential.user!.uid,
          email: email,
          username: username,
          photoUrl: photoUrl,
          bio: bio,
          followers: [],
          followings: [],
        );

        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toJson());

        // another method without using the unique uid

        // await _firestore.collection('users').add({
        //   'uid': credential.user!.uid,
        //   'username': username,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'followings': [],
        // });
        result = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        result = 'Password must be atleast 6 characters';
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    // initial
    String result = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        // if everything was fined
        result = "success";
      } else {
        // nothing
        result = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        result = "Email is already in use";
      } else if (error.code == "weak-password") {
        result = "Password must be atleast 6 characters";
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  // for logging or signing out the user
  Future<void> logOut() async {
    await _auth.signOut();
  }
}
