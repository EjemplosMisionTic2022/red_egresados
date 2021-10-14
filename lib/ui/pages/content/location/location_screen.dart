import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/data/services/location.dart';
import 'package:red_egresados/domain/models/location.dart';
import 'package:red_egresados/domain/use_cases/controllers/authentication.dart';
import 'package:red_egresados/domain/use_cases/controllers/connectivity.dart';
import 'package:red_egresados/domain/use_cases/controllers/location.dart';
import 'package:red_egresados/domain/use_cases/controllers/notification.dart';
import 'package:red_egresados/domain/use_cases/controllers/permissions.dart';
import 'package:red_egresados/domain/use_cases/controllers/ui.dart';
import 'package:red_egresados/domain/use_cases/location_management.dart';
import 'widgets/location_card.dart';

class LocationScreen extends StatelessWidget {
  // UsersOffers empty constructor
  LocationScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();
  final permissionsController = Get.find<PermissionsController>();
  final connectivityController = Get.find<ConnectivityController>();
  final uiController = Get.find<UIController>();
  final locationController = Get.find<LocationController>();
  final notificationController = Get.find<NotificationController>();
  final service = LocationService();

  @override
  Widget build(BuildContext context) {
    final _uid = authController.currentUser!.uid;
    final _name = authController.currentUser!.displayName ?? "User";
    _init(_uid, _name);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => locationController.location != null
                ? LocationCard(
                    key: const Key("myLocationCard"),
                    title: 'MI UBICACIÓN',
                    lat: locationController.location!.lat,
                    long: locationController.location!.long,
                    onUpdate: () {
                      if (permissionsController.locationGranted &&
                          connectivityController.connected) {
                        _updatePosition(_uid, _name);
                      }
                    },
                  )
                : const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // ListView on remaining screen space
          Obx(() {
            if (locationController.location != null) {
              var futureLocations = service.fecthData(
                map: locationController.location!.toJson,
              );
              return FutureBuilder<List<UserLocation>>(
                future: futureLocations,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!;
                    notificationController.show(
                        title: 'Egresados cerca.',
                        body:
                            'Hay ${items.length} egresados cerca de tu ubicación...');
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        UserLocation location = items[index];
                        return LocationCard(
                          title: location.name,
                          distance: location.distance,
                        );
                      },
                      // Avoid scrollable inside scrollable
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }

  _init(String uid, String name) {
    if (!permissionsController.locationGranted) {
      permissionsController.manager.requestGpsPermission().then((granted) {
        if (granted) {
          locationController.locationManager = LocationManager();
          _updatePosition(uid, name);
        } else {
          uiController.screenIndex = 0;
        }
      });
    } else {
      locationController.locationManager = LocationManager();
      _updatePosition(uid, name);
    }
    notificationController.createChannel(
        id: 'users-location',
        name: 'Users Location',
        description: 'Other users location...');
  }

  _updatePosition(String uid, String name) async {
    final position = await locationController.manager.getCurrentLocation();
    locationController.location = MyLocation(
        name: name, id: uid, lat: position.latitude, long: position.longitude);
  }
}
