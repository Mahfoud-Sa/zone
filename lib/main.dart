import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zone_fe/screens/recipients/views/recipients_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home/views/home_screen.dart';
import 'screens/login/view/login_screen.dart';
import 'splash.dart';

late  Database db;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({
  //   Key? key,
  // }) : super(key: key);
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.amber,
    appBarTheme: const AppBarTheme(
        color: Colors.amber,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Myfont"),
        iconTheme: IconThemeData(color: Colors.black)),
    dividerColor: Colors.black,
    splashColor: Colors.black,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
    shadowColor: Colors.amber,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme,
      // darkTheme: ThemeService().darkTheme,
      // themeMode: ThemeService().getThemeMode(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/login": (context) => const LogInScreen(),
        "/home": (context) => const HomeScreen(),
      },
      home: const Splash(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale("ar"),
      supportedLocales: const [Locale("ar")],
    );
  }
}
