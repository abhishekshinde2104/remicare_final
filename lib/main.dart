// ignore_for_file: prefer_const_constructors, unused_import, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remicare/home_pages/login_screen.dart';
import 'package:remicare/home_pages/patient_home.dart';
import 'package:remicare/reminder/app_init.dart';
import 'package:remicare/reminder/push_notification_reminder.dart';

// Future func() async{
//   FirebaseFirestore.instance
//     .collection('reminders')
//     .add({'med_name': 'dolo_2',
//           'med_power':'35',
//     });
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', //id
//   'High Importance Notification', //title
//   //'This channel is used for  important notification', //description
//   importance: Importance.high,
//   playSound: true
// );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
//   await Firebase.initializeApp();
//   print('A bg message just showed up:${message.messageId}');
// }

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//  	print(message.notification!.title);
// 	}


Future main() async {
  appInit();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  //NotificationService().initNotification();
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
      home:DocAssLoginScreen(),
    );
  }
}

//This is a comment
