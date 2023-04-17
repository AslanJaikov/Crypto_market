import 'package:flutter/material.dart';

class currency_container extends StatelessWidget {
  const currency_container({
    super.key,
    required this.value,
    required this.selectCurrency,
    required this.cryptoCurrency,
  });

  final String? cryptoCurrency;
  final String? value;
  final String? selectCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Color(0xFFF3BB2B),
            ),
          ),
        ),
      ),
    );
  }
}
