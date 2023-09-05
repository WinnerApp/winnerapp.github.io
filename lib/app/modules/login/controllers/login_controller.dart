import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<void> githubLogin() async {
    final account = Account(client);
    var host = 'http://localhost:53137';
    if (kReleaseMode) {
      host = 'https://winnerapp.github.io';
    }

    try {
      await account.createOAuth2Session(
        provider: 'github',
        success: '$host/auth.html',
      );
      final user = await account.get();
      final userPrefs = await account.getPrefs();
      global.userR.value = user;
      Get.back();
    } catch (e) {
      Get.snackbar('登录失败', e.toString());
    }
  }
}
