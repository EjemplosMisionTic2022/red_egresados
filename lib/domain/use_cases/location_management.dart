import 'package:geolocator/geolocator.dart';
import 'package:red_egresados/data/repositories/shared_preferences.dart';
import 'package:red_egresados/data/services/geolocation.dart';

class LocationManager {
  final gpsService = GpsService();
  final _sharedPrefs = LocalPreferences();

  Future<Position> getCurrentLocation() async {
    return await gpsService.getCurrentLocation();
  }

  Future<void> storeUserDetails(
      {required String uid, required String name}) async {
    await _sharedPrefs.storeData("CurrentUserId", uid);
    await _sharedPrefs.storeData("CurrentUserName", name);
  }

  Future<Map<String, String>> retrieveUserDetails() async {
    final uid =
        await _sharedPrefs.retrieveData<String>('CurrentUserId') ?? "User";
    final name =
        await _sharedPrefs.retrieveData<String>('CurrentUserName') ?? "uid";
    return {"uid": uid, "name": name};
  }
}
