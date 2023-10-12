import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';

import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await global.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder.put(() => global),
    ),
  );
}
