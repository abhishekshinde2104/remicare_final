// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remicare/home_pages/login_screen.dart';
import 'package:remicare/home_pages/doc_ass_home.dart';
//test

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return DocAssHomeScreen();
    } else {
      return DocAssLoginScreen();
    }
  }
}
