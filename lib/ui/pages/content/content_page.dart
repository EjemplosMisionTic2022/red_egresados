import 'package:flutter/material.dart';
import 'package:red_egresados/ui/widgets/appbar.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tile: Text("Red Egresados"),
        context: context,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Container(
            child: Center(
              child: Text("Red Egresados"),
            ),
          ),
        ),
      ),
    );
  }
}
