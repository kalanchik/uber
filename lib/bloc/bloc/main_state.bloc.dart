part of 'main_bloc.bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class LoadDataState extends MainState {
  final String url;
  final UberInfo uberInfo;

  LoadDataState({required this.url, required this.uberInfo});
}

final class PaymentState extends MainState {
  final Stream<String> statusStream;

  PaymentState({required this.statusStream});
}
