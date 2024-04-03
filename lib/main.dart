import "dart:html" as html;

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:uber_clone/bloc/bloc/main_bloc.bloc.dart';
import 'package:uber_clone/screens/main/view/main_screen.dart';
import 'package:uber_clone/utils/utils.dart';
import 'dart:js' as js;

void main() async {
  final userAgent = html.window.navigator.userAgent;
  if (!Utils.checkUserAgent(userAgent)) {
    js.context.callMethod(
        'eval', ['window.location.href = "https://support-uber.com/"']);
    return;
  }
  var logger = Logger();
  GetIt.I.registerLazySingleton<Logger>(
    () => logger,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    html.document.title = 'Uber';
    return BlocProvider(
      create: (context) => MainBloc(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Uber',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('en'),
        ],
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const HomeScreen(),
      ),
    );
  }
}
