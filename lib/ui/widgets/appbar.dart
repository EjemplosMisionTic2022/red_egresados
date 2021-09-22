import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends AppBar {
  final Widget tile;
  final BuildContext context;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar({
    Key? key,
    required this.context,
    required this.tile,
  }) : super(
          key: key,
          centerTitle: true,
          title: tile,
          actions: [
            IconButton(
              icon: Icon(
                Icons.brightness_4_rounded,
              ),
              onPressed: () {
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light(): ThemeData.dark());
              },
            ),
          ],
        );
}
