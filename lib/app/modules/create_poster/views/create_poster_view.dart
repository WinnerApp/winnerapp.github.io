import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_poster_controller.dart';

class CreatePosterView extends GetView<CreatePosterController> {
  const CreatePosterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreatePosterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreatePosterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
