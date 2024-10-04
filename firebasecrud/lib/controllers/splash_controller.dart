import 'package:firebasecrud/constants/app_strings.dart';
import 'package:firebasecrud/models/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

class SplashController extends GetxController {
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    firebaseServices.getUsers().then((response) {
      Future.delayed(const Duration(seconds: 4), () {
        debugPrint(response.first.name);
        Get.offNamed(AppStrings.homeRoute, arguments: response);
      });
    }).catchError((error) {
      debugPrint('Failed to fetch users: $error');

    });
  }
}
