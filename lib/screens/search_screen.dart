import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(labelText: 'Search for user'),
            onFieldSubmitted: (String _value) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where('username', isGreaterThanOrEqualTo: searchController.text)
          // .where('uid',isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen(uid: snapshot.data!.docs[index]['uid']))),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data!.docs[index]['photoUrl']),
                      ),
                      title: Text(snapshot.data!.docs[index]['username']),
                    ),
                  );
                });
          },
        )
            :
        // const Text('Post'));
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('datePublished', descending: true)
                .get(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    snapshot.data!.docs[index]['postUrl'],
                    fit: BoxFit.cover,
                  );
                },
                staggeredTileBuilder: (int index) {
                  return MediaQuery.of(context).size.width > webScreenSize
                      ? StaggeredTile.count((index % 7 == 0) ? 1 : 1,
                      (index % 7 == 0) ? 1 : 1)
                      : StaggeredTile.count((index % 7 == 0) ? 2  : 1,
                      (index % 7 == 0) ? 2 : 1);
                },
              );
            }));
  }
}
