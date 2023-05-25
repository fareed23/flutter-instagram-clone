import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
import 'package:instagram_clone/widgets/custom_non_clickable_button.dart';
import 'package:instagram_clone/widgets/custom_textfield.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool toggle = false;
  bool _isLoading = false;

  @override
  void initState() {
    if (mounted) {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          setState(() {
            CustomRoundButton(
              title: "Log in",
              onPressed: () {},
            );
          });
        }
        // else {
        //   setState(() {
        //     CustomNonClickableButton(
        //       title: "Log in",
        //       onPressed: () {},
        //     );
        //   });
        // }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // method for logging in the user void because it is not returning anything
  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    // TODO FIND BUG HERE
    String result = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result == "success") {
      // navigate to home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          );
        }),
      );
    } else {
      showSnackBar(result, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          // bottom: MediaQuery.of(context).viewInsets.bottom,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 1, child: Container()),

              // instagram logo
              Image.asset(
                'assets/images/instagram_font.png',
                height: 190,
                width: 190,
              ),

              // email textfield
              CustomTextField(
                textEditingController: _emailController,
                hintText: "Phone number, username or email",
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
                    setState(() {
                      toggle = toggle ? false : true;
                    });
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

              // forgot password?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot password?"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // login button
              (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty)
                  ? CustomRoundButton(
                      title: "Log in",
                      onPressed: loginUser,
                      isLoading: _isLoading ? true : false,
                    )
                  : CustomNonClickableButton(title: "Log in", onPressed: () {}),

              const SizedBox(height: 24),

              // -----or-----

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 110,
                    height: 1,
                    color: Colors.grey[800],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Center(
                      child: Text(
                        'OR',
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 110,
                    height: 1,
                    color: Colors.grey[800],
                  ),
                ],
              ),

              Flexible(child: Container()),

              // text -> don't have an account? sign up

              const Divider(
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: secondaryColor),
                      ),
                      TextButton(
                        onPressed: navigateToSignUp,
                        child: const Text("Sign Up."),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
