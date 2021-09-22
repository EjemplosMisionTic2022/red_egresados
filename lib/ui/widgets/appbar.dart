import 'package:flutter/material.dart';

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
        );
}
