import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  final FocusNode searchFocusNode = FocusNode();
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(color: mobileSearchColor),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        title: SizedBox(
          height: 45,
          child: TextFormField(
            controller: searchController,
            focusNode: searchFocusNode,
            cursorColor: secondaryColor,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: secondaryColor,
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              fillColor: mobileSearchColor,
              filled: true,
            ),
            onFieldSubmitted: (String _) {
              // same as searchController i.e, (_) = (searchController.text)

              searchFocusNode.unfocus();
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            uid: snapshot.data.docs[index]['uid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data.docs[index]['photoUrl'],
                          ),
                        ),
                        title: Text(
                          snapshot.data.docs[index]['username'],
                        ),
                        subtitle: Text(
                          snapshot.data.docs[index]['bio'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, AsyncSnapshot snapshot) {
                // or if(snapshot.connectionState = connectionState.waiting) is the same thing
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => Image.network(
                    snapshot.data.docs[index]['postUrl'],
                  ),
                  staggeredTileBuilder: (index) => width > webScreenSize
                      ? StaggeredTile.count(
                          (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                      : StaggeredTile.count(
                          (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            ),
    );
  }
}
