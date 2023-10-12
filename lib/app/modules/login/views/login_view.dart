import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:flutter_winnerapp_website/gen/assets.gen.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '选择登录方式进行登录',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
            icon: Assets.images.githubMark.image(color: Colors.white),
            label: const Text(
              'Github',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            onPressed: () => controller.githubLogin(),
          ),
        ],
      ),
    );
  }
}
