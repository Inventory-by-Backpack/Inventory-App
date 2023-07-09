import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'binding/auth_bindings.dart';
import 'router/route_manager.dart';
import 'theme/theme_data.dart';
import 'translate/local.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isDarkMode = prefs.getBool('theme') ?? false;
  String languageCode = prefs.getString('language') ?? 'en';

  runApp(MainApp(isDarkMode: isDarkMode, languageCode: languageCode));
}

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key, required this.isDarkMode, required this.languageCode});
  final bool isDarkMode;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      translations: Localization(),
      title: 'Inventory',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      initialRoute: RouteManagement.initialRoute,
      getPages: RouteManagement.routeList,
      initialBinding: AuthBindings(),
      locale: Locale(languageCode),
    );
  }
}
