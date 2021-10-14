import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:red_egresados/domain/services/notification.dart';

class NotificationService implements NotificationInterface {
  final _plugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _plugin.initialize(initializationSettings);
  }

  @override
  NotificationDetails createChannel(
      {required String id, required String name, required String description}) {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      id,
      name,
      channelDescription: description,
      importance: Importance.max,
      priority: Priority.max,
    );
    return NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  @override
  Future<void> showNotification(
      {required String title,
      required String body,
      required NotificationDetails details}) async {
    await _plugin.show(0, title, body, details);
  }
}
