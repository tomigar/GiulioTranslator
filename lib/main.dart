import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/language_selector_provider.dart';
import 'providers/translate_text_provider.dart';

import 'package:translator_app/screens/HomeScreen.dart';
import 'package:translator_app/screens/ScannerScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageSelectProvider()),
        ChangeNotifierProvider(create: (_) => TranslateTextProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Giulio',
        
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(235, 235, 237, 1),
          primaryColor: Color.fromRGBO(58, 88, 244, 1),
          appBarTheme: AppBarTheme(color: Color.fromRGBO(58, 88, 244, 1)),
          fontFamily: 'Sen',
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          "/home": (ctx) => HomeScreen(),
          "/scanner": (ctx) => ScannerScreen(),
        });
  }
}
