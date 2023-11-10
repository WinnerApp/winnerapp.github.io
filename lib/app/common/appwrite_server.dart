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
          .then((value) => value.response);
    } catch (e) {
      return AppwriteServerResponse(-1, e.toString());
    }
    ;
  }
}

extension ExecutionState on Execution {
  bool get isWaiting => status == 'waiting';
  bool get isProcessing => status == 'processing';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';

  AppwriteServerResponse get response {
    if (isFailed) {
      return AppwriteServerResponse(responseStatusCode, errors);
    } else {
      final jsonValue = json.decode(responseBody);
      return AppwriteServerResponse(
        JSON(jsonValue)['code'].intValue,
        JSON(jsonValue)['message'].string,
        JSON(jsonValue)['data'].rawValue,
      );
    }
  }
}

class AppwriteServerResponse {
  final int code;
  final String? message;
  final dynamic data;

  AppwriteServerResponse(this.code, this.message, [this.data]);

  bool get isSuccess => code == 200;
}
