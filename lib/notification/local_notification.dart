import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _showNotification() async {
    // ✅ Request permission on Android 13+
    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      PermissionStatus status = await Permission.notification.request();

      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification permission denied')),
        );
        return;
      }
    }

    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel',
      channelDescription: 'This is the default notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      '🔔 Hello!',
      'This is a local notification.',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Notification')),
      body: Center(
        child: ElevatedButton(
          onPressed: _showNotification,
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}
