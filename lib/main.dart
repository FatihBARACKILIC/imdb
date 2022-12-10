import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/screen/home/home_widget.dart';
import 'package:imdb/screen/onboard_screens/onboard.dart';
import 'package:imdb/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const IMDbApp());
}

class IMDbApp extends StatelessWidget {
  const IMDbApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return DesignWidget(
          themeMode: themeMode,
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _showOnboardScreen = true;

  @override
  void initState() {
    super.initState();
    darkModeController();
    showOnboardScreen();
  }

  darkModeController() async {
    bool result = await SharedPreferencesHelper.darkMode();
    setState(() {
      IMDbApp.themeNotifier.value =
          result == true ? ThemeMode.dark : ThemeMode.light;
    });
  }

  showOnboardScreen() async {
    bool result = await SharedPreferencesHelper.showOnboardScreen();
    setState(() {
      _showOnboardScreen = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showOnboardScreen ? const OnboardWidget() : const HomeWidget();
  }
}
