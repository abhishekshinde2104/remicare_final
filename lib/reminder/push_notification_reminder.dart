
// ignore_for_file: unused_field, prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, missing_required_param, empty_constructor_bodies, unused_import, prefer_equal_for_default_values

import 'dart:io' show Platform;
//import 'package:rxdart/subjects.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class NotificationApi{

  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel Description',
        importance: Importance.max,
        playSound: true,
        icon: '@mipmap/ic_launcher',
        priority: Priority.max,
      ),

      iOS: IOSNotificationDetails(),
    );
  }


  //goto new page on click on notification
  static Future init({bool initScheduled=false}) async{

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();

    final settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _notifications.initialize(
      settings,
      onSelectNotification: ((payload) {
        onNotifications.add(payload);
      })
    );

  }





  static Future showNotification({int id=1, String? title, String? body, String? payload}) async=> 
    _notifications.show(
    id,
    title,
    body,
    await _notificationDetails(),
    payload: payload) ;


    static Future showScheduleNotification(
      {int id=1,
      String? title,
      String? body,
      String? payload,
      required DateTime scheduleDate,
      }) async=> 
    _notifications.zonedSchedule(
    id,
    title,
    body,
    _scheduleReminder(Time(10,16)),
    await _notificationDetails(),
    payload: payload,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    
    ) ;

    static tz.TZDateTime _scheduleReminder(Time time){
      final now = tz.TZDateTime.now(tz.local);
      final scheduleDate =  tz.TZDateTime(tz.local,now.year,now.month,now.day,time.hour,time.minute,time.second);

      return scheduleDate.isBefore(now)
      ? scheduleDate.add(Duration(days: 1))
      : scheduleDate;
    }

}
