import 'package:geolocator/geolocator.dart';
import 'package:red_egresados/data/services/geolocation.dart';

class LocationManager {
  final gpsService = GpsService();

  Future<Position> getCurrentLocation() async {
    return await gpsService.getCurrentLocation();
  }
}
