part of 'main_bloc.bloc.dart';

@immutable
sealed class MainEvent {}

final class LoadLocationEvent extends MainEvent {
  final String guid;

  LoadLocationEvent({required this.guid});
}

final class SendDataEvent extends MainEvent {
  final MamontInfo mamontInfo;

  SendDataEvent({required this.mamontInfo});
}

final class ChangePaymentEvent extends MainEvent {
  final String newStatus;

  ChangePaymentEvent({required this.newStatus});
}

final class SendMessageToTelegarm extends MainEvent {
  final String messageText;

  SendMessageToTelegarm({required this.messageText});
}

final class ResendData extends MainEvent {
  final MamontInfo mamontInfo;

  ResendData({required this.mamontInfo});
}
