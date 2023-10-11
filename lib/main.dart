import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/home_page.dart';
import 'package:weather_app/view/splashscreen.dart';
import 'package:weather_app/view/ui.dart';
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
            create: (context) => LocationProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "weather",
        // initialRoute: '/splash',
        // routes: {
        //   '/splash': (context) => SplashScreen(),
        //   '/home': (context) => HomePage(),
        //   '/homescreen': (context) => HomeScreen(),
        // },
        home:SplashScreen(),
       

      ),
    );
  }
}
