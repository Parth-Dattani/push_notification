import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    NotificationService.init(initScheduled: true);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });

    AwesomeNotifications().actionStream.listen((event) {
      print("event noti recived");
      print(event.toMap().toString());
    });
    RemoteMessage msg;

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      debugPrint("Messages");
      print("Message : $msg");
      print("Message : ${msg.notification!.body}");
      print("Message : ${msg.notification!.body.toString()}");
      print("Message : ${msg.data.keys}");
      print("Message : ${msg.data.values}");

      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 12,
            channelKey: 'channelKey1',
            title: msg.notification!.title?? 'Awesome Notification',
            body:  msg.notification!.body ??  'this is Awesome Notification',
            bigPicture: "https://media.istockphoto.com/id/1194343598/vector/bright-modern-mega-sale-banner-for-advertising-discounts-vector-template-for-design-special.jpg?s=612x612&w=0&k=20&c=oxeukxA1kVLBuLtcbipu_94blsVGs9eU0V_x70wkVzA=",
            notificationLayout: NotificationLayout.BigPicture
        ),

      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(msg.notification!.title?? ''
      //     ),
      //   ),
      // );
    });
    // getToken();
    // initmsg();
    //NotificationService.initialize();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(id: 2,
          title:  message.notification!.title,
          body: message.notification!.body,
      );
    });
    super.initState();
  }
  // void getToken(){
  //   FirebaseMessaging msg ;
  //   FirebaseMessaging.getToken().then((value) {
  //     String token = value;
  //     print(token);
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.teal[200],
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.teal,
        title: const Text("Home Page "),
        actions: [
          IconButton(onPressed: (){
            print("dfgg");
            NotificationService.showNotification(
              id: 0,
              title: "E-commerce",
              body: "Hello, user this for only Testing purpose.",
              //payload: "E-commerce",
            );
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[

            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'call',
        child: const Icon(Icons.call),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




