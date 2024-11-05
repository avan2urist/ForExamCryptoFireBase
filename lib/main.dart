import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/account_screen.dart';
import 'package:flutter_firebase_auth/crypto_coin_screen.dart';
import 'package:flutter_firebase_auth/crypto_list.dart';
import 'package:flutter_firebase_auth/firebase_streem.dart';
import 'package:flutter_firebase_auth/home_screen.dart';
import 'package:flutter_firebase_auth/login_screen.dart';
import 'package:flutter_firebase_auth/reset_password_screen.dart';
import 'package:flutter_firebase_auth/signup.dart.dart';
import 'package:flutter_firebase_auth/theme.dart';
import 'package:flutter_firebase_auth/verify_email_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darktheme.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => const HomeScreen(),
        '/account': (context) => const AccountScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
        '/crypto_list': (context) => const CryptoListScreen(),
        '/coin': (context) => const CryptoCoinScreen(),
      },
      initialRoute: '/',
    );
  }
}
