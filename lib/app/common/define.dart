import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const mainColor = Color(0xff3CBBC0);

/// 保存全局的信息
class GlobalController extends GetxController {}

Client client = Client()
  ..setEndpoint('https://cloud.appwrite.io/v1')
  ..setProject('winner-app')
  ..setSelfSigned(status: true);
