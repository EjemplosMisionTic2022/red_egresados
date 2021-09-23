import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final String picUrl;
  final Widget tile;
  final VoidCallback onSignOff;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar(
      {Key? key,
      required this.context,
      required this.picUrl,
      required this.tile,
      required this.onSignOff})
      : super(
          key: key,
          centerTitle: true,
          leading: Center(
            child: CircleAvatar(
              minRadius: 18.0,
              maxRadius: 18.0,
              backgroundImage: NetworkImage(picUrl),
            ),
          ),
          title: tile,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.brightness_4_rounded,
              ),
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: onSignOff,
            )
          ],
        );
}
