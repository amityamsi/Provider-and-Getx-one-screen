import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test/app/getx/login_controller.dart';
import 'package:test/app/providers/login_provider.dart';
import 'package:test/app/ui/show_data.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return SafeArea(child: Scaffold(
      body: Consumer<LoginProvider>(builder:
          (BuildContext context, LoginProvider loginProvider, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profilePicSection(
                    loginProvider: loginProvider, context: context),
                textFieldSection(loginProvider),
                genderSelectionSection(
                    loginController: loginController,
                    loginProvider: loginProvider),
                customSaveBtn(
                    loginProvider.isFormFilled ? Colors.blue : Colors.grey,
                    context,
                    loginProvider),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: checkValidationBtn(
                      context: context, loginProvider: loginProvider),
                )
              ],
            ),
          ),
        );
        ;
      }),
    ));
  }

  Widget checkValidationBtn(
      {required context, required LoginProvider loginProvider}) {
    return GestureDetector(
      onTap: () {
        loginProvider.checkFormValidation(context);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blueGrey,
        ),
        child: const Center(child: Text('Check Validation')),
      ),
    );
  }

  Widget customSaveBtn(Color? color, context, LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          loginProvider.isFormFilled
              ? {
                  loginProvider.saveData(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowDataScreen()))
                }
              : null;
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * .5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: color,
          ),
          child: const Center(child: Text('Save')),
        ),
      ),
    );
  }

  Widget genderSelectionSection(
      {required LoginController loginController,
      required LoginProvider loginProvider}) {
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'Select Your Gender',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: loginController.genderList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender';
        }
      },
      onChanged: (value) {
        loginController.onSelectionChanged(value);
        loginProvider.validateForm();
      },
      onSaved: (value) {},
    );
  }

  Widget profilePicSection(
      {required LoginProvider loginProvider, required BuildContext context}) {
    return Stack(alignment: Alignment.center, children: [
      // CircleAvatar(
      //   radius: 50,
      //   backgroundImage: loginProvider.profilePic != null
      //       ? Image.file(loginProvider.profilePic!, fit: BoxFit.cover).image
      //       : const AssetImage('assets/images/blue.jpg'),
      // ),

      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        margin: const EdgeInsets.only(top: 20),
        width: 200,
        height: 200,
        child: (loginProvider.profilePic != null)
            ? Image.file(
                loginProvider.profilePic!,
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.image,
                size: 200,
              ),
      ),
      Positioned(
          child: GestureDetector(
        onTap: () {
          loginProvider.getImageFromCamera();
        },
        child: const Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
        ),
      ))
    ]);
  }

  Widget textFieldSection(LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TextField(
        onChanged: (value) {
          loginProvider.validateForm();
        },
        controller: loginProvider.textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          labelText: 'username',
        ),
      ),
    );
  }
}
