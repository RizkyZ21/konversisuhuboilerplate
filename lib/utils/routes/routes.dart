import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/konversi_suhu.dart';
import 'package:boilerplate/bloc/suhu/suhu_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {

  Routes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';
  static const String suhu = '/suhu';

  static final routes = <String, WidgetBuilder>{

    login: (context) => LoginScreen(),

    home: (context) => HomeScreen(),

    suhu: (context) => BlocProvider(

      create: (_) => SuhuBloc(),

      child: KonversiSuhu(),

    ),

  };

}