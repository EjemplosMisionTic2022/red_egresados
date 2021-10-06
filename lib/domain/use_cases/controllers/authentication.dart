import 'package:get/get.dart';

class AuthController extends GetxController {
  // Observables
  final _authenticated = false.obs;

  set authenticated(bool state) {
    _authenticated.value = state;
  }

  // Reactive Getters
  RxBool get reactiveAuth => _authenticated;

  // Getters
  bool get authenticated => _authenticated.value;
}
