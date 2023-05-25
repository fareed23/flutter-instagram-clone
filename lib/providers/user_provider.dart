import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  // Global Variable private field _userModel
  UserModel? _userModel;
  final AuthMethods _authMethods = AuthMethods();

  // Getter for user
  UserModel get getUser => _userModel!;

  // Function for refresing the user in provider
  Future<void> refreshUser() async {
    UserModel userModel = await _authMethods.getUserDetails();
    _userModel = userModel;
    notifyListeners();
  }
}
