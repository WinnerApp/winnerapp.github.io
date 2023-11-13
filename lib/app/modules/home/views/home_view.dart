import 'dart:ui';

import 'package:appwrite/models.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:flutter_winnerapp_website/app/common/document_extened.dart';
import 'package:flutter_winnerapp_website/app/modules/login/views/login_view.dart';
import 'package:flutter_winnerapp_website/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:random_x/random_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('稳健医疗  App  团队技术官网'),
          centerTitle: false,
          backgroundColor: mainColor,
          toolbarHeight: 100,
          actions: [
            if (!controller.isLogin)
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
            if (controller.isLogin)
              IconButton(
                onPressed: () => Get.toNamed(Routes.CREATE_POSTER),
                icon: const Icon(Icons.add),
              ),
            if (controller.isLogin)
              TextButton(
                onPressed: () {},
                child: Text(
                  global.user?.name ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            if (controller.isLogin)
              IconButton(
                onPressed: () {
                  controller.logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(50.0),
          color: Colors.grey.shade300,
          child: Column(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                leading: Text('文章列表',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Obx(
                  () {
                    final count = controller.articles.length;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 20,
                        childAspectRatio: 150 / 100,
                      ),
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.articles[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ARTICLE_DETAIL, arguments: item);
                          },
                          child: BackdropFilter(
                            filter: ImageFilter.blur(),
                            child: buildBackground(
                              document: item,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    tileMode: TileMode.repeated,
                                    colors: [
                                      Colors.black.withOpacity(0.2),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black,
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Text(
                                      item.getTitle ?? '',
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.getDate ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackground({required Document document, required Widget child}) {
    final backgroundImage = document.getBackground;
    if (backgroundImage == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.repeated,
            colors: [
              RndX.randomColor,
              Colors.black.withAlpha(100),
            ],
          ),
        ),
        child: child,
      );
    }
    return Stack(
      children: [
        ExtendedImage.network(backgroundImage),
        child,
      ],
    );
  }
}
