import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  // Observables
  final _connected = false.obs;

  //ACTIVIDAD
  // Implemente la actualización del estado de conectividad 
  // set connectivity(ConnectivityResult connectivity) {
  // }

  // Getters
  bool get connected => _connected.value;
}
