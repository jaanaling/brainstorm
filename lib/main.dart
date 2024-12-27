import 'dart:async';

import 'package:brainstorm_quest/src/core/dependency_injection.dart';
import 'package:brainstorm_quest/src/feature/app/presentation/app_root.dart';
import 'package:core_logic/core_logic.dart';
import 'package:core_amplitude/core_amplitude.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  setupDependencyInjection();

  await InitializationUtil.coreInit(
    domain: 'brainstormquest.com',
    facebookClientToken: 'bf76e0edd7bbbf17c1a8121434115f40',
    facebookAppId: '435883139461989',
    amplitudeKey: '7c4a885514b1864018cd85a8776ea7be',
    appsflyerDevKey: '33buTv4Nz24HVyvJPuXpn7',
    appId: 'com.dreamcircuit.brainstormquest',
    iosAppId: '6739791552',
    initialRoute: '/home',
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const AppRoot(),
  );
  }, (Object error, StackTrace stackTrace) {
    _handleAsyncError(error, stackTrace);
  });
}

void _handleFlutterError(FlutterErrorDetails details) {
  AmplitudeUtil.logFailure(
    details.exception is Exception ? Failure.exception : Failure.error,
    details.exception.toString(),
    details.stack,
  );
}

void _handleAsyncError(Object error, StackTrace stackTrace) {
  AmplitudeUtil.logFailure(
    error is Exception ? Failure.exception : Failure.error,
    error.toString(),
    stackTrace,
  );
}

class ScreenLayout extends StatelessWidget {
  final Widget topSection;
  final Widget middleSection;
  final Widget bottomSection;

  ScreenLayout({
    required this.topSection,
    required this.middleSection,
    required this.bottomSection,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          topSection,
          Expanded(child: middleSection),
          bottomSection,
        ],
      ),
    );
  }
}
