import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  // to control the jumping of pages
  void navigateTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  // to control the bottom tab bar of pages
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'assets/images/instagram_font.png',
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigateTapped(0),
            icon: const Icon(Icons.home),
            color: _page == 0 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigateTapped(1),
            icon: const Icon(Icons.search),
            color: _page == 1 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigateTapped(2),
            icon: const Icon(Icons.add_a_photo),
            color: _page == 2 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigateTapped(3),
            icon: const Icon(Icons.favorite),
            color: _page == 3 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigateTapped(5),
            icon: const Icon(Icons.person),
            color: _page == 5 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () => navigateTapped(4),
            icon: const Icon(Icons.messenger_outline_sharp),
            color: _page == 4 ? primaryColor : secondaryColor,
          ),
        ],
      ),
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
