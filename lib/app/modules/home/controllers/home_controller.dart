import 'package:appwrite/models.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_winnerapp_website/app/common/appwrite_server.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool get isLogin => global.user != null;

  var articles = <Document>[].obs;
  var total = 0;

  HomeController() {
    requestArticles();
  }

  Future<void> requestArticles() async {
    SmartDialog.showLoading();
    final result = await AppwriteServer().getPosters();
    SmartDialog.dismiss();
    final data = result.data;
    if (data == null) {
      SmartDialog.showToast(result.message ?? '获取文章失败');
      return;
    }
    total = data.total;
    articles.value = data.list;
  }
}
