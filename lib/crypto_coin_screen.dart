import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); // Вызовите super в начале метода
    final args = ModalRoute.of(context)?.settings.arguments;

    // Проверяем, что аргумент не null и является строкой
    if (args != null && args is String) {
      coinName = args; // Получаем название криптовалюты
    } else {
      coinName =
          'Unknown Coin'; // Обработка случая, если аргумент не был передан
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'), // Отображаем название криптовалюты
        centerTitle: true,
      ),
      body: Center(
        child: Text(
            'Details for $coinName'), // Отображаем информацию о криптовалюте
      ),
    );
  }
}
