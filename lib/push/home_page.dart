import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      debugPrint("Messages");

      print("Message : $msg");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg.notification!.title?? ''
          ),
        ),
      );
    });
    // getToken();
    // initmsg();

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
          IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
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

