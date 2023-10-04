import 'package:fllutter_notif_2/firebase/firebase_api.dart';
import 'package:fllutter_notif_2/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseApi.initialize(flutterNotificationPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseApi.showBigTextNotification(
                  flutterNotificationPlugin: flutterNotificationPlugin,
                  id: 1,
                  title: "title",
                  body: "body");
            },
            child: Text("Home Click")),
      ),
    );
  }
}
