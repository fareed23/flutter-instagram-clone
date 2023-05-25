import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class CustomNonClickableButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomNonClickableButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: secondaryColor),
          ),
        ),
      ),
    );
  }
}
