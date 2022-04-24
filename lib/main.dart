// ignore_for_file: prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remicare/home_pages/login_screen.dart';
import 'package:remicare/home_pages/patient_home.dart';
import 'package:remicare/reminder/app_init.dart';

// Future func() async{
//   FirebaseFirestore.instance
//     .collection('reminders')
//     .add({'med_name': 'dolo_2',
//           'med_power':'35',
//     });
// }

Future main() async {
  appInit();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await func();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: PatientHome(),
    );
  }
}

//This is a comment
