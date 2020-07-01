import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!_initialized) {
      getFcmToken();
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('OnMessage --------------- $message');
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(message['notification']['title']),
              content: Text(message['notification']['body']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ],
            ),
          );
        },
      );
      _initialized = true;
    }
  }

  Future<void> getFcmToken() async {
    String token = await _firebaseMessaging.getToken();
    print('TOKEN ----------- $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification through FCM'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}
