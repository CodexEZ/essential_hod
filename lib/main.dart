import 'package:ess_ward/pages/splash.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Essential Warden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.primaryColor,
        colorScheme: const ColorScheme.light(
            primary: Colors.primaryColor, secondary: Colors.secondaryColor),
        useMaterial3: false,
      ),
      home: SplashScreen(),
    );
  }
}
