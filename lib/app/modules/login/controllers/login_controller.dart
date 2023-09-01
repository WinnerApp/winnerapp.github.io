import 'package:appwrite/appwrite.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<void> githubLogin() async {
    final account = Account(client);
    try {
      await account.createOAuth2Session(provider: 'github');
    } catch (e) {
      print(e);
    }
  }
}
