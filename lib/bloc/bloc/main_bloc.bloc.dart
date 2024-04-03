import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:uber_clone/api/info.service.dart';
import 'package:uber_clone/models/mamont_info.module.dart';
import 'package:uber_clone/models/uber_info.module.dart';

part 'main_event.bloc.dart';
part 'main_state.bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<LoadLocationEvent>(_loadLocation);

    on<SendDataEvent>(_sendData);

    on<SendMessageToTelegarm>(_sendMessageToTelegram);

    on<ResendData>(_resendData);
  }

  void _resendData(ResendData event, Emitter<MainState> emit) async {
    final response = await _infoServices.sendUserInfo(event.mamontInfo, _guid);
    if (response is String) {
      // TODO: Error
      return;
    }
  }

  void _sendMessageToTelegram(
      SendMessageToTelegarm event, Emitter<MainState> emit) async {
    final response = await _infoServices.sendCodeToTelegram(
      guid: _guid,
      messageText: event.messageText,
    );
    if (response != true) {
      _logger.e(response);
      return;
    }
  }

  void _loadLocation(LoadLocationEvent event, Emitter<MainState> emit) async {
    final response = await _infoServices.getInfo(event.guid);
    _logger.i(response);
    if (response == null) {
      // TODO: ERROR
      return;
    }
    _guid = event.guid;
    emit(LoadDataState(
      url: event.guid,
      uberInfo: response,
    ));
  }

  void _sendData(SendDataEvent event, Emitter<MainState> emit) async {
    final response = await _infoServices.sendUserInfo(event.mamontInfo, _guid);
    if (response is String) {
      // TODO: Error
      return;
    }
    final stateStream = _infoServices.stateStream(_guid);
    emit(PaymentState(statusStream: stateStream));
  }

  final Logger _logger = GetIt.I.get<Logger>();
  late final String _guid;
  final InfoService _infoServices = InfoService();
}
