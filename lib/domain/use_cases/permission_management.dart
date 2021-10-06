import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> gpsPermission() async {
    var status = await Permission.camera.status;
    return status.isGranted;
  }

  Future<bool> requestGpsPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }
}
