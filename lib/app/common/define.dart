import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

const mainColor = Color(0xff3CBBC0);
const double appBarHeight = 100;
final logger = Logger(
  filter: DevelopmentFilter(),
);

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
    final user = await readUserFromLocal();
    if (user != null) {
      userR.value = user;
    }
  }

  // 保存用户信息到本地
  Future<void> saveUserInLocal(User user) {
    final userJson = json.encode(user.toMap());
    return SharedPreferences.getInstance()
        .then((value) => value.setString(userKey, userJson));
  }

  Future<User?> readUserFromLocal() async {
    String? userJson = await SharedPreferences.getInstance()
        .then((value) => value.getString(userKey));
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

const appwriteServerFunctionId = 'dart_server';
