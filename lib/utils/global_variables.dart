import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_latest/screens/add_post_screen.dart';
import 'package:flutter_instagram_latest/screens/feed_screen.dart';
import 'package:flutter_instagram_latest/screens/profile_screen.dart';
import 'package:flutter_instagram_latest/screens/search_screen.dart';
const webScreenSize = 900;
List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];