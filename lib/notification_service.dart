import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static Future init({bool initScheduled = false}) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/notification');
        //AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentAlert: true,
    );
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    void onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) {
      print('id $id');
    }


    await notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload.toString());
        print("onNotifications value : $onNotifications");
        print("pay load on Did Receive $payload");
      },
      // onSelectNotification: selectNotification
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final location = await FlutterNativeTimezone.getLocalTimezone();
      print("location : ${location.toString()}");
      print("location India: ${location[1]}");
      print("location India 2: ${location[2]}");
      tz.setLocalLocation(tz.getLocation('America/Detroit'));
      //tz.setLocalLocation(tz.getLocation(location.toString()));
    }
  }

  void selectNotification(String payload) async {
    //Handle notification tapped logic here
    /*onNotifications.add(payload);*/
    print(payload);
  }

  static awesomeNoti()async{
    String time = await AwesomeNotifications().getLocalTimeZoneIdentifier();
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 12,
            channelKey: 'channelKey1',
          title: 'Awesome Notification',
          body: 'this is Awesome Notification',
          bigPicture: "https://media.istockphoto.com/id/1194343598/vector/bright-modern-mega-sale-banner-for-advertising-discounts-vector-template-for-design-special.jpg?s=612x612&w=0&k=20&c=oxeukxA1kVLBuLtcbipu_94blsVGs9eU0V_x70wkVzA=",
          notificationLayout: NotificationLayout.BigPicture
        ),
     //      schedule: NotificationInterval(
     //     interval: 5,
     //     timeZone: time,
     //     repeats: true
     // )
     );
  }

  //1. Local Notification
  static showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async =>
      notifications.show(id,title, body, await notificationDetails());

  //this methode is use for any local notification
  static Future notificationDetails() async {
    //final bigPicture = ImagePath.profileLogo;

    const androidNotificationDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      enableLights: true,
      channelShowBadge: true,
      sound: RawResourceAndroidNotificationSound('whistle'),

      // largeIcon: DrawableResourceAndroidBitmap('justwater'),
      // styleInformation: BigPictureStyleInformation(
      //   FilePathAndroidBitmap('justwater'),
      //   hideExpandedLargeIcon: false,
      // ),
      // color:  Color(0xff2196f3),
    );
    const iosNotificationDetails = DarwinNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails);
  }
}
