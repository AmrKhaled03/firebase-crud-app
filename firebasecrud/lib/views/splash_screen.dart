import 'package:firebasecrud/constants/app_strings.dart';
import 'package:firebasecrud/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
            Lottie.asset("assets/jsons/Animation - 1724950152231.json"),
              const SizedBox(
                height: 20,
              ),
               Text(
                AppStrings.appTitle.toUpperCase(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        )),
      ),
    ));
  }
}
