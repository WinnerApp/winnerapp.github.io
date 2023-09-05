import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool get isLogin => global.user != null;
}
