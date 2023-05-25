import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class CustomRoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  const CustomRoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: primaryColor,
                )
              : Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
        ),
      ),
    );
  }
}
