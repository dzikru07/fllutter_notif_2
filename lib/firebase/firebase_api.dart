import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterNotificationPlugin) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    await flutterNotificationPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      String title = "title",
      String body = "body",
      var payload,
      required FlutterLocalNotificationsPlugin
          flutterNotificationPlugin}) async {
    AndroidNotificationDetails androidPlatformChannelSpesific =
        AndroidNotificationDetails(
      'madanai_channel',
      'chennerl name',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,
    );

    var not = NotificationDetails(android: androidPlatformChannelSpesific);

    await flutterNotificationPlugin.show(id, title, body, not,
        payload: payload);
  }

  Future<void> iniNotification() async {
    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    final token = await _firebaseMessaging.getToken();

    print('Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification!.body}');
      }

      showBigTextNotification(
          flutterNotificationPlugin: flutterNotificationPlugin,
          id: 1,
          title: message.notification!.title!,
          body: message.notification!.body!);
    });

    // background message handler

    // awesome_notification handler
  }
}
