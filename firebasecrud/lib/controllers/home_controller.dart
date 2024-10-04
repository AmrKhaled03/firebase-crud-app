import 'package:firebasecrud/models/services/firebase_services.dart';
import 'package:firebasecrud/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseServices firebaseServices = FirebaseServices();
  List<UserModel> users = [];
  dynamic response = Get.arguments;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool isLoading = false;

  void addUser() async {
    if (name.text.isEmpty || email.text.isEmpty || phone.text.isEmpty) {
      Get.snackbar("Error", "All fields must be filled out");
      return;
    }

    try {
      isLoading = true;
      update();
      String userId = await firebaseServices.insertUser(
        name: name.text,
        email: email.text,
        phone: phone.text,
      );

      UserModel newUser = UserModel(
        id: userId,
        name: name.text,
        email: email.text,
        phone: phone.text,
      );
      users.add(newUser);
      update();

      name.clear();
      email.clear();
      phone.clear();

      Fluttertoast.showToast(
        msg: "User added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error adding user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  void deleteTheUser({required String id}) async {
    try {
      isLoading = true;
      update();

      await firebaseServices.deleteUser(id: id);

      users.removeWhere((user) => user.id == id);
      update();

      Fluttertoast.showToast(
        msg: "User deleted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Error deleting user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> showEditDialog(UserModel user) async {
    name.text = user.name;
    email.text = user.email;
    phone.text = user.phone;

    return Get.defaultDialog(
      title: "Edit User",
      content: Column(
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(labelText: "Phone"),
          ),
        ],
      ),
      onConfirm: () async {
        Get.back();
        await showConfirmationDialog(user.id);
      },
      onCancel: () {
        Get.back();
      },
      textConfirm: "Save",
      textCancel: "Cancel",
    );
  }

  Future<void> showConfirmationDialog(String userId) async {
    return Get.defaultDialog(
      title: "Confirm Update",
      middleText: "Are you sure you want to update this user's information?",
      onConfirm: () async {
        Get.back();
        await updateUser(userId);
      },
      onCancel: () {
        Get.back();
      },
      textConfirm: "Yes",
      textCancel: "No",
    );
  }

  Future<void> updateUser(String userId) async {
    if (name.text.isEmpty || email.text.isEmpty || phone.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "All fields must be filled out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    try {
      isLoading = true;
      update();

      await firebaseServices.updateUser(
        id: userId,
        name: name.text,
        email: email.text,
        phone: phone.text,
      );
      UserModel userToUpdate = users.firstWhere((user) => user.id == userId);
      userToUpdate.name = name.text;
      userToUpdate.email = email.text;
      userToUpdate.phone = phone.text;
      Fluttertoast.showToast(
        msg: "User updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      name.clear();
      email.clear();
      phone.clear();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error updating user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    checkResponse();
  }

  void checkResponse() {
    if (response != null && response is List<UserModel>) {
      users.assignAll(response);
      debugPrint(users.length.toString());
    }
  }
}
