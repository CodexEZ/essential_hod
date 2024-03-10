import 'package:ess_hod/pages/splash.dart';
import 'package:ess_hod/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<DisplayMode> modes = <DisplayMode>[];

  DisplayMode? active;

  DisplayMode? preferred;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchAll();
    });
  }

  Future<void> fetchAll() async {
    try {
      modes = await FlutterDisplayMode.supported;
      modes.forEach(print);

      /// On OnePlus 7 Pro:
      /// #1 1080x2340 @ 60Hz
      /// #2 1080x2340 @ 90Hz
      /// #3 1440x3120 @ 90Hz
      /// #4 1440x3120 @ 60Hz

      /// On OnePlus 8 Pro:
      /// #1 1080x2376 @ 60Hz
      /// #2 1440x3168 @ 120Hz
      /// #3 1440x3168 @ 60Hz
      /// #4 1080x2376 @ 120Hz
    } on PlatformException catch (e) {
      print(e);

      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
    }

    preferred = await FlutterDisplayMode.preferred;

    active = await FlutterDisplayMode.active;
    print(active);
    if(modes[1].refreshRate == 120)
      await FlutterDisplayMode.setPreferredMode(modes[1]);
    active = await FlutterDisplayMode.active;
    print(active);
    setState(() {});
  }

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
