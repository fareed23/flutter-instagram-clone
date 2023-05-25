import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/bottom_sheet.dart';
import 'package:instagram_clone/widgets/custom_small_button.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // an empty object
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    // get data from the user
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      // get posts length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;
      // get followers length because it is a list
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['followings'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0),
            child: Scaffold(
              appBar: AppBar(
                // leading: const Icon(
                //   Icons.lock,
                //   size: 15,
                // ),
                backgroundColor: mobileBackgroundColor,
                title: Text(userData['username']),
                titleSpacing: 25,
                centerTitle: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const MyBottomSheet();
                          });
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 25),
                            child: CircleAvatar(
                              backgroundColor: secondaryColor,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 40,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatColumn(postLength, "Posts"),
                                      buildStatColumn(followers, "Followers"),
                                      buildStatColumn(following, "Following"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 10, left: 25),
                        child: Text(
                          userData['bio'],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              // our profile
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    CustomSmallButton(
                                      text: "Edit Profile",
                                    ),
                                    CustomSmallButton(
                                      text: "Share Profile",
                                    ),
                                  ],
                                )

                              // others profile we follow
                              : isFollowing
                                  ? FollowButton(
                                      text: "Unfollow",
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      borderColor: secondaryColor,
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                    )
                                  // others profile we don't follow
                                  : FollowButton(
                                      text: "Follow",
                                      backgroundColor: blueColor,
                                      textColor: primaryColor,
                                      borderColor: blueColor,
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    ),
                        ],
                      ),
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   padding: const EdgeInsets.only(top: 18),
                      //   child: Text(
                      //     userData['username'],
                      //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.builder(
                        // padding: const EdgeInsets.only(top: 6),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap = snapshot.data.docs[index];

                          return Container(
                            child: Image(
                              image: NetworkImage(
                                snap['postUrl'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }
}

Column buildStatColumn(int num, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        num.toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    ],
  );
}
