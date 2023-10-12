import 'package:get/get.dart';

import '../controllers/create_poster_controller.dart';

class CreatePosterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePosterController>(
      () => CreatePosterController(),
    );
  }
}
