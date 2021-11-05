import 'package:flutter/material.dart';
import 'package:red_egresados/ui/widgets/card.dart';

class StateCard extends StatelessWidget {
  final String title, content, picUrl;
  final VoidCallback onChat;

  // StateCard constructor
  const StateCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.picUrl,
      required this.onChat})
      : super(key: key);

  // Creamos un widget Stateless que contiene una AppCard,
  // Pasando todas las vistas personalizables como parámetros
  @override
  Widget build(BuildContext context) {
    //Implementa el widget con ayuda del instructor
  }
}
