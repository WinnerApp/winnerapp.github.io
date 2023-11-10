import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_winnerapp_website/app/common/define.dart';

import 'package:get/get.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../controllers/create_poster_controller.dart';

class CreatePosterView extends GetView<CreatePosterController> {
  const CreatePosterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新建文章'),
        centerTitle: true,
        backgroundColor: mainColor,
        toolbarHeight: appBarHeight,
        actions: [
          IconButton(
            onPressed: () => controller.publishPoster(),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: '请输入文章标题.....'),
              controller: controller.titleController,
            ),
            const Divider(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const MarkdownToolbar(useIncludedTextField: false),
                        Expanded(
                          child: fluent.TextBox(
                            expands: true,
                            controller: controller.contentController,
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Expanded(
                        child: MarkdownWidget(
                      data: controller.markdownContent.value,
                    )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
