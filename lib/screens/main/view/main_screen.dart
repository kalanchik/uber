import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc/bloc/main_bloc.bloc.dart';
import 'package:uber_clone/models/uber_tarifs.module.dart';
import 'package:uber_clone/screens/main/widgets/sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final url = html.window.location.href;
    final String guid = url.split('?')[1];
    context.read<MainBloc>().add(LoadLocationEvent(guid: guid));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is LoadDataState) {
            final UberTarifs uberTarifs = UberTarifs.init(state.uberInfo);
            return Stack(
              children: [
                SizedBox(
                  child: Image.network(
                    'http://91.222.236.174:8080/img/${state.url}',
                  ),
                ),
                SizedBox(
                  child: CustomSheet(
                    uberInfo: state.uberInfo,
                    basic: uberTarifs.basic,
                    popular: uberTarifs.popular,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Image.asset(
              'assets/images/loading.gif',
              width: 100,
              height: 100,
            ),
          );
        },
      ),
    );
  }
}
