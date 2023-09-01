import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';

import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder.put(() => GlobalController()),
    ),
  );
}
