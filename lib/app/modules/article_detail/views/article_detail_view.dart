import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';
import 'package:flutter_winnerapp_website/app/common/document_extened.dart';

import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  const ArticleDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.document.getTitle ?? ''),
        toolbarHeight: appBarHeight,
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MarkdownWidget(
          data: controller.document.getContent ?? '',
        ),
      ),
    );
  }
}
