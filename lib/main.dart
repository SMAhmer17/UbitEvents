import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ubitevents/auth/loginScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 4));
  FlutterNativeSplash.remove();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
   
        title: 'UBIT EVENTS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor:Colors.white,
          appBarTheme: AppBarTheme(
              elevation: 2,
              centerTitle: true,
              color: Color.fromARGB(255, 255, 197, 36)),

          // scaffoldBackgroundColor: Color.fromARGB(255, 157, 180, 155),

          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 161, 11)),
          useMaterial3: true,
        ),
        home: loginScreen()
        );
  }
}
