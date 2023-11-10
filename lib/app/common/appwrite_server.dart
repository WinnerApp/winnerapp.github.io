import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:darty_json_safe/darty_json_safe.dart';

import 'define.dart';

class AppwriteServer {
  // final Databases databases = Databases(client);
  final Functions functions = Functions(client);

  /// 发布文章
  /// [title] 文章的标题
  /// [content] 文章的内容
  Future<AppwriteServerResponse> publishPoster(
    String title,
    String content,
  ) async {
    try {
      return functions
          .createExecution(
            functionId: appwriteServerFunctionId,
            path: '/publish_article',
            method: 'POST',
            body: json.encode({
              'title': title,
              'content': content,
            }),
          )
          .then((value) => value.response());
    } catch (e) {
      return AppwriteServerResponse(-1, e.toString());
    }
  }

  /// 获取文章列表
  Future<AppwriteServerResponse<AppwriteServerResponseList>> getPosters(
      [String? cursorId]) async {
    try {
      final execution = await functions.createExecution(
        functionId: appwriteServerFunctionId,
        path: '/getArticleList',
        method: 'GET',
        body: json.encode({
          'pageNumber': 20,
          'cursorId': cursorId,
        }),
      );
      return execution.response<AppwriteServerResponseList>((data) {
        final list = AppwriteServerResponseList.fromJson(data);
        return list;
      });
    } catch (e) {
      logger.e(e.toString());
      return AppwriteServerResponse<AppwriteServerResponseList>(
          -1, e.toString());
    }
  }
}

extension ExecutionState on Execution {
  bool get isWaiting => status == 'waiting';
  bool get isProcessing => status == 'processing';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';

  AppwriteServerResponse<T> response<T>(
      [T Function(dynamic data)? dataConver]) {
    if (isFailed) {
      return AppwriteServerResponse(responseStatusCode, errors);
    } else {
      final jsonValue = json.decode(responseBody);
      final data = JSON(jsonValue)['data'].rawValue;
      final value = Unwrap(dataConver).map((e) {
        if (data == null) return null;
        final value = e.call(data);
        logger.d(e.runtimeType);
        return e(data);
      });
      final code = JSON(jsonValue)['code'].intValue;
      final message = JSON(jsonValue)['message'].string;
      if (dataConver != null) {
        return AppwriteServerResponse<T>(
          code,
          message,
          Unwrap(dataConver).map((e) {
            if (data == null) return null;
            return e(data);
          }).value,
        );
      } else {
        return AppwriteServerResponse<T>(
          code,
          message,
          data,
        );
      }
    }
  }
}

class AppwriteServerResponse<T> {
  final int code;
  final String? message;
  final T? data;

  AppwriteServerResponse(this.code, this.message, [this.data]);

  bool get isSuccess => code == 200;
}

class AppwriteServerResponseList {
  late int total;
  late List<Document> list;

  AppwriteServerResponseList.fromJson(Map<String, dynamic> json) {
    total = JSON(json)['total'].intValue;
    list =
        JSON(json)['list'].listValue.map((e) => Document.fromMap(e)).toList();
  }
}
