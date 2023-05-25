import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
import 'package:instagram_clone/widgets/custom_non_clickable_button.dart';
import 'package:instagram_clone/widgets/custom_textfield.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  bool toggle = false;
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        setState(() {
          CustomRoundButton(
            title: "Log in",
            onPressed: () {},
          );
        });
      } else {
        setState(() {
          CustomNonClickableButton(
            title: "Log in",
            onPressed: () {},
          );
        });
      }
    });
    super.initState();
  }

  // Select profile picture
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().signupUser(
      email: _emailController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      password: _passwordController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (result != 'success') {
      showSnackBar(result, context);
    } else {
      // navigate to home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // instagram image
            SizedBox(
              height: 50, // for bigger screens 150
              child: Image.asset(
                'assets/images/instagram_font.png',
                height: 190,
                width: 190,
              ),
            ),

            // profile picture to show the user
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 60,
                        // MemoryImage which takes Uint8File
                        backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage('assets/images/default_profile.png'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 70,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            // email textfield
            CustomTextField(
              textEditingController: _emailController,
              hintText: "Email",
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 22),

            // username textfield
            CustomTextField(
              textEditingController: _usernameController,
              hintText: "Username",
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 22),

            // bio textfield
            CustomTextField(
              textEditingController: _bioController,
              hintText: "Bio",
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 22),

            // password textfield
            CustomTextField(
              textEditingController: _passwordController,
              hintText: "Password",
              textInputType: TextInputType.text,
              isPass: toggle ? false : true,
              icon: InkWell(
                onTap: () {
                  toggle = toggle ? false : true;
                },
                child: toggle
                    ? const Icon(
                        Icons.visibility,
                        size: 29,
                        color: secondaryColor,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        size: 29,
                        color: secondaryColor,
                      ),
              ),
            ),

            Flexible(flex: 1, child: Container()),

            // sign up button
            (_emailController.text.isNotEmpty &&
                    _bioController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty)
                ? CustomRoundButton(
                    title: "Sign up",
                    onPressed: signUpUser,
                    isLoading: _isLoading,
                  )
                : CustomNonClickableButton(title: "Sign up", onPressed: () {}),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
