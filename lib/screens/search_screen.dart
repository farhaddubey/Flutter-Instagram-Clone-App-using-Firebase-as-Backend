import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_latest/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose(){
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Search for a User'
          ),
          onFieldSubmitted: (String _){
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers ?
      FutureBuilder(
        future: FirebaseFirestore.instance.collection('users')
        .where('username', isGreaterThanOrEqualTo: searchController.text)
        .get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.hasData! as dynamic).docs.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl']
                    ),
                  ),
                );
          });
        },
      ):
      FutureBuilder(
        // From firebase we need to collect the data in future so using FutureBUilder
        // all function using firebase are async and data loads uses awaits
        future: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return MasonryGridView.count(
            crossAxisCount: 3,
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => Image.network(
              (snapshot.data! as dynamic).docs[index]['postUrl'],
              fit: BoxFit.cover,
            ),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
        },
      ),
    );
  }
}

