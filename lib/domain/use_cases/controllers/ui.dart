import 'package:get/get.dart';

class UIController extends GetxController {
  // Observables
  final _screenIndex = 0.obs;

  set screenIndex(int index) {
    _screenIndex.value = index;
  }

  // Reactive Getters
  RxInt get reactiveScreenIndex => _screenIndex;

  // Getters
  int get screenIndex => _screenIndex.value;
}
