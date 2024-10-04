import 'package:firebasecrud/constants/app_strings.dart';
import 'package:firebasecrud/controllers/home_controller.dart';
import 'package:firebasecrud/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            AppStrings.appTitle,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controller.name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)),
                        onPressed: () {
                          controller.addUser();
                        },
                        child: const Text("Add User",style:TextStyle(color: Colors.white,fontSize: 25),),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: controller.users.length,
                      itemBuilder: (_, index) {
                        UserModel user = controller.users[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.detailsRoute,
                                arguments: user);
                          },
                          child: Dismissible(
                            key: Key(user.id),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              controller.deleteTheUser(id: user.id);
                            },
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              tileColor: user.deleted
                                  ? Colors.red[100]
                                  : Colors.deepPurple,
                              title: Text(
                                user.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                user.email,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              leading: Hero(
                                tag: user.id,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 30,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: controller.isLoading
                                  ? const CircularProgressIndicator()
                                  : IconButton(
                                      onPressed: () {
                                        controller.showEditDialog(user);
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
