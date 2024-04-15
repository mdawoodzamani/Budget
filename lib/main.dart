import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:hive/hive.dart';

import '/screens/home_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox('extras');
  await Locales.init(['en', 'fa', 'zh', 'ar', 'es', 'hi']);
  if (Hive.box('extras').isEmpty) {
    Hive.box('extras').put('budget', 0);
    Hive.box('extras').put('totalIncome', 0);
    Hive.box('extras').put('totalExpense', 0);
    Hive.box('extras').put('calender', 'gregorain');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scrollbarTheme: ScrollbarThemeData(
            interactive: true,
            radius: const Radius.circular(10.0),
            thumbColor:
                MaterialStateProperty.all(Colors.deepOrange.withOpacity(0.6)),
            thickness: MaterialStateProperty.all(20.0),
            minThumbLength: 100,
          ),
          primaryColor: Colors.deepOrange,
          colorScheme: const ColorScheme.dark(
            surface: Colors.deepOrange,
            // color of app bar
            onSurface: Colors.white,
            // everything on appbar
            secondary: Colors.deepPurple,
            // floating action button
            onSecondary: Colors.white,
            // everything on FAB
            primary: Colors.deepOrange, // background of the buttons
          ).copyWith(secondary: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
