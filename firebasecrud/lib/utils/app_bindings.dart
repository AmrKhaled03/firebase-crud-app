import 'package:firebasecrud/controllers/home_controller.dart';
import 'package:firebasecrud/controllers/splash_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);

  }
}
