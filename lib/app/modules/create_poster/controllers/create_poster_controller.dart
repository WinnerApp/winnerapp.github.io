import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_winnerapp_website/app/common/appwrite_server.dart';
import 'package:get/get.dart';

class CreatePosterController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  var markdownContent = ''.obs;

  CreatePosterController() {
    contentController.addListener(() {
      markdownContent.value = contentController.text;
    });
  }

  /// 发布文章
  publishPoster() async {
    final title = titleController.text;
    final content = contentController.text;
    if (title.isEmpty) {
      SmartDialog.showToast('请输入文章标题!');
      return;
    }
    if (content.isEmpty) {
      SmartDialog.showToast('请输入文章内容!');
      return;
    }
    SmartDialog.showLoading();
    final response = await AppwriteServer().publishPoster(title, content);
    SmartDialog.dismiss();
    if (!response.isSuccess) {
      SmartDialog.showToast(response.message ?? '未知报错!');
      return;
    }
    SmartDialog.showToast('发布成功!');
  }
}
