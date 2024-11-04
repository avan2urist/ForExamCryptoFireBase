import 'package:flutter/material.dart';

class CryptoCoin {
  CryptoCoin({
    required this.name,
    required this.priceInUSD,
    required this.imageUrl,
  });

  final String name;
  final double priceInUSD;
  final String imageUrl;
}

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(coin.imageUrl),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coin.name);
      },
      subtitle: Text(
        '${coin.priceInUSD}\$',
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}
