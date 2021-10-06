import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/use_cases/controllers/connectivity.dart';
import 'package:red_egresados/domain/use_cases/controllers/permissions.dart';
import 'package:red_egresados/domain/use_cases/controllers/ui.dart';
import 'widgets/location_card.dart';

class LocationScreen extends StatefulWidget {
  // UsersOffers empty constructor
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LocationScreen> {
  final items = List<String>.generate(8, (i) => "Item $i");
  late PermissionsController permissionsController;
  late ConnectivityController connectivityController;
  late UIController uiController;

  @override
  void initState() {
    super.initState();
    permissionsController = Get.find<PermissionsController>();
    connectivityController = Get.find<ConnectivityController>();
    uiController = Get.find<UIController>();
    if (!permissionsController.locationGranted) {
      permissionsController.manager.requestGpsPermission().then((granted) {
        if (granted) {
          log("permission granted");
        } else {
          uiController.screenIndex = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          LocationCard(
            key: const Key("myLocationCard"),
            title: 'MI UBICACIÓN',
            lat: 11.004556423794284,
            long: -74.7217010498047,
            onUpdate: () {
              if (permissionsController.locationGranted &&
                  connectivityController.connected) {
                log("TODO update location");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // ListView on remaining screen space
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return LocationCard(
                title: 'John Doe',
                lat: 11.004556423794284,
                long: -74.7217010498047,
                distance: 25,
                onUpdate: () {},
              );
            },
            // Avoid scrollable inside scrollable
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
