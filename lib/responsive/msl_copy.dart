import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_latest/models/user.dart' as model;
import 'package:flutter_instagram_latest/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MSL extends StatefulWidget {
  const MSL({Key? key}) :super(key: key);

  @override
  State<MSL> createState() => _MSLState();
}

class _MSLState extends State<MSL> {
  String username = "";
  @override
  void initState(){
    super.initState();
    // init can not be async and firebase always returns in future hence all firebase related methods must be async
    getUsername();
  }
  void getUsername() async{
    DocumentSnapshot snapshot=await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // doc(FirebaseAuth.instance.currentUser!.uid).get() can be access only one time that's named as snape that is snapped for once
    print(snapshot.data());
    setState(() {
      username=(snapshot.data() as Map<String, dynamic>)['username'];
    });

  }
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text(user.username),
      ),
    );
  }
}
