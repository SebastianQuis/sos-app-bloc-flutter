import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:sos_harold_app/bloc/blocs.dart';
import 'package:sos_harold_app/helpers/helpers.dart';
import 'package:sos_harold_app/routes/app_routes.dart';
import 'package:sos_harold_app/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const AppState());
}


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => AuthBloc()),
        BlocProvider( create: (context) => UsersBloc()),
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificacionService.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'SOS APP',
      home: const UsuarioSeleccionaScreen(),
      routes: AppRoutes.getAppRoutes(),
      initialRoute: AppRoutes.initialRoute,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffffffff)
      ),
    );
  }
}