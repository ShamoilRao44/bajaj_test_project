import 'package:bajaj_test_project/home/home_vm.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeVM());
  }
}
