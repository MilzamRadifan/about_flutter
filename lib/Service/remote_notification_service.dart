import 'package:event_management_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RemoteNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print('FCM Token: $fcmToken');

    initPushNotification();
  }

  void handleNotification(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed('/remote-notification', arguments: message);
  }

  Future initPushNotification() async {
    _firebaseMessaging.getInitialMessage().then(handleNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  }
}
