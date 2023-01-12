import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/push/home_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   final navKey = GlobalKey<NavigatorState>();
  await Firebase.initializeApp;
  print('Handling a background message ${message.messageId}');
    //showDialogIfFirstLoaded(context);
  // showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Notification"),
  //         content: Text(message.notification!.body!),
  //         actions: [
  //           TextButton(
  //             child: Text("Ok"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       );
  //     });
}

Future<void> _firdf( RemoteMessage msg)async{
  await Firebase.initializeApp;
  print('Handling a foreground message ${msg.messageId}');
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = await FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    sound: true,
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false
  );

  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print("Permission Granted");
  }
  else if(settings.authorizationStatus == AuthorizationStatus.provisional){
    print("Permission provisional Granted");
  }
  else{
    print("Permission Not Granted");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler,);

  runApp(const MyApp());
}

showDialogIfFirstLoaded(BuildContext context, prefs) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return  AlertDialog(          // title: new Text("title"),
          content:  const Text("Notification"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

