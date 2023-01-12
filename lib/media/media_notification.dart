// import 'package:flutter/material.dart';
// import 'package:flutter_media_notification/flutter_media_notification.dart';
//
// void main() => runApp( MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   _MyAppState createState() =>  _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String status = 'hidden';
//
//   @override
//   void initState() {
//     super.initState();
//
//     MediaNotification.setListener('pause', () {
//       setState(() => status = 'pause');
//     });
//
//     MediaNotification.setListener('play', () {
//       setState(() => status = 'play');
//     });
//
//     MediaNotification.setListener('next', () {});
//
//     MediaNotification.setListener('prev', () {});
//
//     MediaNotification.setListener('select', () {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       home:  Scaffold(
//         appBar:  AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body:  Center(
//             child: SizedBox(
//               height: 250.0,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   ElevatedButton(
//                       child: const Text('Show notification'),
//                       onPressed: () {
//                         MediaNotification.showNotification(
//                             title: 'Title', author: 'Song author');
//                         setState(() => status = 'play');
//                       }),
//                   ElevatedButton(
//                       child: const Text('Update notification'),
//                       onPressed: () {
//                         MediaNotification.showNotification(
//                             title: 'New Title',
//                             author: 'New Song author',
//                             isPlaying: false);
//                         setState(() => status = 'pause');
//                       }),
//                   ElevatedButton(
//                       child: const Text('Hide notification'),
//                       onPressed: () {
//                         MediaNotification.hideNotification();
//                         setState(() => status = 'hidden');
//                       }),
//                   Text('Status: $status')
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
