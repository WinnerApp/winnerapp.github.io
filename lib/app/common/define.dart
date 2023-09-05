import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const mainColor = Color(0xff3CBBC0);

/// 保存全局的信息
class GlobalController extends GetxController {
  static final GlobalController _instace = GlobalController._();
  factory GlobalController() => _instace;
  GlobalController._();

  var userR = Rxn<User>();

  /// 当前登录的用户信息
  User? get user => userR.value;

  var userPrefsR = Rxn<Preferences>();

  /// 当前登录的用户配置
  Preferences? get userPrefs => userPrefsR.value;
}

final global = GlobalController();

Client client = Client()
  ..setEndpoint('https://cloud.appwrite.io/v1')
  ..setProject('winner-app')
  ..setSelfSigned(status: true);
