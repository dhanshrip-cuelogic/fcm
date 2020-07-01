import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  PushNotificationManager._();

  static final PushNotificationManager _instance = PushNotificationManager._();

  factory PushNotificationManager() {
    return _instance;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      String token = await _firebaseMessaging.getToken();
      print("The Token is --------- $token");

      _initialized = true;
    }
  }
}
