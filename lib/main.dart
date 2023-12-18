import 'package:coffee_labs_hq/providers/cupping_screen_provider.dart';
import 'package:coffee_labs_hq/providers/login_screen_provider.dart';
import 'package:coffee_labs_hq/providers/main_screen_provider.dart';
import 'package:coffee_labs_hq/screens/login_screen.dart';
import 'package:coffee_labs_hq/screens/main_screen.dart';
import 'package:coffee_labs_hq/services/application_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenProvider()),
    ChangeNotifierProvider(create: (context) => LoginScreenProvider()),
    ChangeNotifierProvider(create: (context) => CuppingScreenProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _main(context);
  }

  Widget _main(BuildContext context) {
    return MaterialApp(
      title: "Cupping Agent",
      navigatorKey: ApplicationNavigator.instance.navigatorKey,
      initialRoute: '/login',
      routes: {
        '/main': (context) => MainScreen(),
        '/login': (context) => LoginScreen(),
      },
      theme: ThemeData(
        // primaryColor: Color.fromRGBO(252, 57, 3, 1.0),
        fontFamily: 'Quicksand',
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(252, 57, 3, 1.0),
          // TRY THIS: Change to "Brightness.light"
          //           and see that all colors change
          //           to better contrast a light background.
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        // Test field themeing
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
          hintStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 96.0, fontWeight: FontWeight.normal),
          displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.normal),
          displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.normal, color: Colors.white),
          headlineLarge: TextStyle(fontSize: 40.0, fontWeight: FontWeight.normal, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 34.0, fontWeight: FontWeight.normal, color: Colors.white),
          headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.white),
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white),
          titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
          titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
          labelMedium: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white),
          labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Color.fromRGBO(252, 57, 3, 1.0)),
        ),
      ),
    );
  }
}
