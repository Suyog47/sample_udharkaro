import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';

class NotificationCheck {
  void check(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final RemoteNotification notification = message.notification;
      final AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        try {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigate().toMainScreen(context);
            if (notification.title.trim() == "Reported") {
              Navigate().toReports(context);
            }
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
