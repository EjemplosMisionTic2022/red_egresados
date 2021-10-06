import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/use_cases/auth_management.dart';

class AuthController extends GetxController {
  // Observables
  final _authenticated = false.obs;
  final _currentUser = Rx<User?>(null);
  late AuthManagement _manager;

  set currentUser(User? userAuth) {
    _currentUser.value = userAuth;
    _authenticated.value = userAuth != null;
  }

  set authManagement(AuthManagement manager) {
    _manager = manager;
  }

  // Reactive Getters
  RxBool get reactiveAuth => _authenticated;

  // Getters
  bool get authenticated => _authenticated.value;

  AuthManagement get manager => _manager;
}
