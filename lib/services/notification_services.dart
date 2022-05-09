import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  String fcmBaseUrl = dotenv.env["FCM_API_BASE_URL"];
  String fcmAuthKey = dotenv.env["FCM_AUTHORIZATION_KEY"];

  FirebaseMessaging fcm;
  String token;

  Future<String> getFcmToken() async {
    await Firebase.initializeApp();
    fcm = FirebaseMessaging.instance;

    fcm.onTokenRefresh;
    await fcm.getToken().then((value) => token = value);
    return token;
  }

  Future sendNotify(String title, String body, String token) async {
    try {
      final url = Uri.https(fcmBaseUrl, '/fcm/send', {'q': '{https}'});

      final header = {
        "Content-Type": "application/json",
        "Authorization": "key = $fcmAuthKey",
      };
      final request = {
        'notification': {'title': title, 'body': body},
        "priority": "high",
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'type': 'COMMENT',
          'sound': 'default',
        },
        'to': token
      };

      final response =
          await http.post(url, headers: header, body: json.encode(request));
      print(response.body);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
