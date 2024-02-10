import 'package:ess_ward/pages/splash.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      home: const SplashScreen(),
    );
  }
}
