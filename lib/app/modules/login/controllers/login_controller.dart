import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<void> githubLogin() async {
    final account = Account(client);
    const host = String.fromEnvironment(
      'HOST',
      defaultValue: 'http://localhost:53137',
    );

    try {
      final result = await account.createOAuth2Session(
        provider: 'github',
        success: '$host/auth.html',
      );
      logger.i(result);

      // final sessionList = await account.listSessions();

      final session = await account.getSession(sessionId: 'current');
      logger.i(session.toMap());
      final user = await account.get();
      logger.i(user.toMap());
      // final userPrefs = await account.getPrefs();
      global.userR.value = user;
      // 保存登录的用户到本地
      global.saveUserInLocal(user);

      Get.back();
    } catch (e) {
      Get.snackbar('登录失败', e.toString());
    }
  }
}
