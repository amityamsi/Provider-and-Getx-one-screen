import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/app/getx/login_controller.dart';

class LoginProvider extends ChangeNotifier {
  LoginController loginController = Get.put(LoginController());

  List details = [];

  File? profilePic;
  ImagePicker imagePicker = ImagePicker();
  bool isFormFilled = false;
  TextEditingController textEditingController = TextEditingController(text: '');

  getImageFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      profilePic = File(pickedFile.path);
      notifyListeners();
      validateForm();
    } else {
      return null;
    }
  }

  validateForm() {
    if ((profilePic == null) ||
        (textEditingController.text == '') ||
        (loginController.selectedValue == null) ||
        (loginController.selectedValue == '')) {
      isFormFilled = false;
      notifyListeners();
    } else {
      isFormFilled = true;
      notifyListeners();
    }
  }

  saveData() {
    details.addAll([
      profilePic!,
      textEditingController.text,
      loginController.selectedValue
    ]);
    notifyListeners();
  }

  checkFormValidation(context) {
    if (profilePic == null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select profile pic")));
    }
    if (textEditingController.text == '') {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter username")));
    }
    if ((loginController.selectedValue == '') ||
        (loginController.selectedValue == null)) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select Gender")));
    } else {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Form Completed")));
    }
  }
}
