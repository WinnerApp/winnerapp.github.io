import 'package:appwrite/models.dart';
import 'package:get/get.dart';

class ArticleDetailController extends GetxController {
  late Document document;
  ArticleDetailController() {
    document = Get.arguments;
  }
}
