import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/theme/weather_theme.dart';
import 'package:weather_app/view/splashscreen.dart';
import 'package:weather_app/viewmodel/provider/theme_provider.dart';
import 'package:weather_app/viewmodel/provider/weather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
            create: (context) => LocationProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider())
      ],
      child: Consumer<ThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "weather",
          theme: value.themeMode
              ? ThemeManager.darkTheme
              : ThemeManager.lightTheme,
          home: const SplashScreen(),
        );
      }),
    );
  }
}
