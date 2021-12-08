import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/screens/ChatScreen.dart';
import 'package:translator_app/screens/SignInScreen.dart';
import 'authentication_service.dart';
import 'providers/language_selector_provider.dart';
import 'providers/translate_text_provider.dart';

import 'package:translator_app/screens/HomeScreen.dart';
import 'package:translator_app/screens/ScannerScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageSelectProvider()),
        ChangeNotifierProvider(create: (_) => TranslateTextProvider()),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
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

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      print("prihlaseny");
      return ChatScreen();
    }
    print("neprihlaseny");
    return SignInScreen();
  }
}
