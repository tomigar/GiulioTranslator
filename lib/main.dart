import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:translator_app/screens/HomeScreen.dart';
import 'package:translator_app/screens/SpeechScreen.dart';
import 'package:translator_app/screens/RegisterScreen.dart';
import 'package:translator_app/screens/SignInScreen.dart';
import 'package:translator_app/widgets/Chat/Location.dart';
import 'package:translator_app/widgets/Chat/Page/ChatsPage.dart';

import 'authentication_service.dart';
import 'providers/language_selector_provider.dart';
import 'providers/translate_text_provider.dart';

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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    context.watch<User>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
          "/scanner": (ctx) => SpeechScreen(),
          "/register": (ctx) => RegisterScreen(),
        });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return ChatsPage();
    } else {
      return SignInScreen();
    }
  }
}
