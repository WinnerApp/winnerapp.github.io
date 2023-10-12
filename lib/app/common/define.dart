import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  init() async {
    final user = readUserFromLocal();
    if (user != null) {
      userR.value = user;
    }
  }

  // 保存用户信息到本地
  void saveUserInLocal(User user) {
    final userJson = json.encode(user.toMap());
    GetStorage().write(userKey, userJson);
  }

  User? readUserFromLocal() {
    String? userJson = GetStorage().read(userKey);
    return Unwrap(userJson).map((e) {
      final user = User.fromMap(json.decode(e));
      return user;
    }).value;
  }

  final userKey = 'user';
}

final global = GlobalController();

Client client = Client()
  ..setEndpoint('https://cloud.appwrite.io/v1')
  ..setProject('winner-app')
  ..setSelfSigned(status: true);
