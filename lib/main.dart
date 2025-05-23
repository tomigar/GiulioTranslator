import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/screens/EditProfile.dart';

import 'package:translator_app/screens/HomeScreen.dart';
import 'package:translator_app/screens/SavedTranslations.dart';
import 'package:translator_app/screens/RegisterScreen.dart';
import 'package:translator_app/screens/SignInScreen.dart';
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
          // primaryColor: Color.fromRGBO(58, 88, 244, 1),
          primaryColor: Color(0xff1CC73B),
          appBarTheme: AppBarTheme(color: Color(0xff1CC73B)),
          splashColor: Colors.deepPurple,

          fontFamily: 'Sen',
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          "/home": (ctx) => HomeScreen(),
          "/saved": (ctx) => SavedTranslations(),
          "/register": (ctx) => RegisterScreen(),
          "/edit-profile": (ctx) => EditProfile(),
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
