import 'package:brainstorm_quest/src/core/dependency_injection.dart';
import 'package:brainstorm_quest/src/feature/app/presentation/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  // await Firebase.initializeApp();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const AppRoot(),
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
