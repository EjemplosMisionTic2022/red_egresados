import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:red_egresados/data/services/notification.dart';

class NotificationManager {
  final _service = NotificationService();

  initialize() async {
    await _service.initialize();
  }

  NotificationDetails createChannel(
      {required String id, required String name, required String description}) {
    return _service.createChannel(id: id, name: name, description: description);
  }

  void showNotification(
      {required NotificationDetails channel,
      required String title,
      required String body}) async {
    await _service.showNotification(title: title, body: body, details: channel);
  }
}
