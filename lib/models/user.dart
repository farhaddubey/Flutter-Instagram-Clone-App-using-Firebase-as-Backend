import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class User {
//   final String email;
//   final String uid;
//   final String photoUrl;
//   final String username;
//   final String bio;
//   final List followers;
//   final List following;
//
//
// const User({
//   required this.email, required this.uid, required this.photoUrl, required this.username, required this.bio, required this.followers,
//   required this.following
// });
// // Below to Json method will convert the object into JSON object
// Map<String, dynamic> toJson() =>{
//   "username":username,
//   "uid":uid,
//   "email":email,
//   "photoUrl":photoUrl,
//   "bio":bio,
//   "followers":followers,
//   "following":following
// };
//
// static User fromSnap(DocumentSnapshot snap){
//   var snapshot = snap.data() as Map<String, dynamic>;
//   return User(
//     username: snapshot['username'],
//     uid: snapshot['uid'],
//     email: snapshot['email'],
//     photoUrl: snapshot['photoUrl'],
//     bio: snapshot['bio'],
//     followers: snapshot['followers'],
//     following: snapshot['following'],
//   );
// }
// }

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.username,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.bio,
        required this.followers,
        required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following,
  };
}