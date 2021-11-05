import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/use_cases/notification_manager.dart';

class NotificationController extends GetxController {
  // Observables
  final _manager = NotificationManager();
  late NotificationDetails _channel;

  initialize() async {
    await _manager.initialize();
  }

  createChannel(
      {required String id, required String name, required String description}) {
    _channel =
        _manager.createChannel(id: id, name: name, description: description);
  }

  show({required String title, required String body}) =>
      _manager.showNotification(channel: _channel, title: title, body: body);
}
