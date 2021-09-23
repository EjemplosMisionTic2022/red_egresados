import 'package:flutter/material.dart';
import 'widgets/location_card.dart';

class LocationScreen extends StatefulWidget {
  // UsersOffers empty constructor
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LocationScreen> {
  final items = List<String>.generate(8, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LocationCard(
          title: 'MI UBICACIÓN',
          lat: 11.004556423794284,
          long: -74.7217010498047,
          onUpdate: () {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'CERCA DE MÍ',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        // ListView on remaining screen space
        Expanded(
          child: ListView.builder(
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
          ),
        ),
      ],
    );
  }
}
