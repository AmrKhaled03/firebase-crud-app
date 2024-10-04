import 'package:firebasecrud/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Get.arguments;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          user.name,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: user.id,
                  child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        user.name.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  user.id.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  user.email.toLowerCase(),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  user.phone,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.deepPurple)),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Back To Users ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
