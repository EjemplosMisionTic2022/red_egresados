import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationInterface {
  void initialize();

  void createChannel(
      {required String id, required String name, required String description});

  void getNotificationDetails(AndroidNotificationDetails details);

  void showNotification(
      {required String title,
      required String body,
      required NotificationDetails details});
}
