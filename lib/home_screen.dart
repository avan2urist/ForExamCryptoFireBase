import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/account_screen.dart';
import 'package:flutter_firebase_auth/crypto_list.dart';
import 'package:flutter_firebase_auth/login_screen.dart';

final darktheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 248, 236, 128),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    bodySmall: TextStyle(
      color: Color.fromARGB(110, 255, 255, 255),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(66, 80, 80, 80),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(66, 114, 114, 114),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  ),
  dividerColor: Colors.white12,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добро пожаловать!'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                darktheme.scaffoldBackgroundColor.withOpacity(0.8),
                const Color.fromARGB(66, 114, 114, 114).withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: darktheme.scaffoldBackgroundColor,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            darktheme.primaryColor.withOpacity(0.9),
                            const Color.fromARGB(110, 255, 255, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (user == null) ...[
                            // Текст для незарегистрированных пользователей
                            Text(
                              "Вы скачали приложение для отслеживания актуального курса криптовалют!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/crypto_image.jpeg',
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ] else ...[
                            // Текст для зарегистрированных пользователей
                            Text(
                              'Вы скачали приложение для отслеживания актуального курса криптовалют!!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Добро пожаловать, ${user.email}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 16,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if ((user == null)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: darktheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Переход к аккаунту',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CryptoListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: darktheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Начать отслеживание',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
