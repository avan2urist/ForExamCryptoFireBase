import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
      // Вошел ура
    } on FirebaseAuthException catch (e) {
      print('Ошибка: ${e.code}');

      // Ищу ошибку
      switch (e.code) {
        case 'user-not-found':
          SnackBarService.showSnackBar(
            context,
            'Пользователь с таким email не найден.',
            true,
          );
          break;
        case 'wrong-password':
          SnackBarService.showSnackBar(
            context,
            'Неверный пароль. Попробуйте еще раз.',
            true,
          );
          break;
        case 'invalid-email':
          SnackBarService.showSnackBar(
            context,
            'Неверный формат email.',
            true,
          );
          break;
        case 'user-disabled':
          SnackBarService.showSnackBar(
            context,
            'Эта учетная запись была отключена.',
            true,
          );
          break;
        case 'operation-not-allowed':
          SnackBarService.showSnackBar(
            context,
            'Аутентификация с email/пароль не включена.',
            true,
          );
          break;
        default:
          print('Вот она проблема ттууууууууууууут: ${e.toString()}');
          SnackBarService.showSnackBar(
            context,
            'Данные введены неправильно, попробуйте еще раз',
            true,
          );
      }
    } catch (e) {
      // Еще ищу
      print('Неизвестная ошибка: ${e.toString()}');
      SnackBarService.showSnackBar(
        context,
        'Неизвестная ошибка: ${e.toString()}',
        true,
      );
    }

    navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Войти'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Введите правильный Email'
                        : null,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите Email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                style: const TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Введите пароль',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                ),
                child: const Center(child: Text('Войти')),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                ),
                child: const Center(child: Text('Регистрация')),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/reset_password'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                ),
                child: const Center(child: Text('Сбросить пароль')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
