import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class CustomSmallButton extends StatelessWidget {
  final String text;
  const CustomSmallButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 60,
      width: 180,
      child: FollowButton(
        text: text,
        backgroundColor: Colors.grey.shade900,
        textColor: primaryColor,
        function: () {},
      ),
    );
  }
}
