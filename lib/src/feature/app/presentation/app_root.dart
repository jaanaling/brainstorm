import 'package:brainstorm_quest/src/feature/game/bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../../routes/go_router_config.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppBloc()..add(LoadData()),
        child: CupertinoApp.router(
          theme: const CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0xFF1895FB),
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(
                fontFamily: 'Jellee',
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: buildGoRouter,
          debugShowCheckedModeBanner: false,
        ));
  }
}
