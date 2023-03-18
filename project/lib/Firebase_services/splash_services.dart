import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Firebase_services/ChooseDataBase.dart';
import 'package:project/UI/auth/firebase_database/post_screen.dart';
import 'package:project/UI/auth/firestore/fire_store_list.dart';
import 'package:project/UI/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
// current user : humein curent login user ka batata hai ..
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseDatebase()
                  // firebase database :
                  //      PostScreen(),
                  //Firestore :
                  // ShowFireStorePostScreen()
                  )));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
