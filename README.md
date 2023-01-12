# push_notification

Simple  Push Notification

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


#parthdattani58
[push-notify]

[Add this function above main]

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
await Firebase.initializeApp;
print('Handling a background message ${message.messageId}');
}

[In Main (){}]
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
runApp(const MyApp());