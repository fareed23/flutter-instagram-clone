import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: MediaQuery.of(context).size.width * 0.02,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.insights),
            title: const Text('Insights'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.local_activity),
            title: const Text('Your activity'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Orders and payments'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Favorites'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Discover people'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: blueColor,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(color: blueColor),
            ),
            onTap: () {
              AuthMethods().logOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
