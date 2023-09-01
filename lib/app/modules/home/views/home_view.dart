import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:flutter_winnerapp_website/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('稳健医疗  App  团队技术官网'),
        centerTitle: false,
        backgroundColor: mainColor,
        toolbarHeight: 100,
        actions: [
          TextButton(
            onPressed: () => Get.dialog(const Dialog(
              backgroundColor: mainColor,
              child: LoginView(),
            )),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '登录',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}