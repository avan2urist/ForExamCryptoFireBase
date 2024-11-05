import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/account_screen.dart';
import 'package:flutter_firebase_auth/crypto_list.dart';
import 'package:flutter_firebase_auth/news.dart';
import 'package:flutter_firebase_auth/signup.dart.dart';

import 'package:flutter_firebase_auth/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      } else if (index == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Чтобы посмотреть новости, пожалуйста, зарегистрируйтесь.')),
        );
      }
    } else {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CryptoListScreen()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountScreen()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MentalHealthNewsScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
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
                            // анрег юзер
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
                            // для рег юзер
                            Text(
                              'Добро пожаловать, ${user.email}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 25,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: user == null
            ? [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Регистрация',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: 'Новости',
                ),
              ]
            : [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.track_changes),
                  label: 'Криптовалюты',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Аккаунт',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: 'Новости',
                ),
              ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
