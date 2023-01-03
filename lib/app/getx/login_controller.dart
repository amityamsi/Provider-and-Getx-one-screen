import 'package:get/get.dart';

class LoginController extends GetxController {
  final genderList = ["Male", "Female", "Other"];
  RxString selectedValue = ''.obs;

  onSelectionChanged(value) {
    selectedValue.value = value;

    print(selectedValue);
  }
}
