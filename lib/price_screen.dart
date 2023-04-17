import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto_market/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'currency_containers.dart';
import 'dart:io' show Platform;
import 'const.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectCurrency = 'USD';

  DropdownButton<String> getAndroidDropDownButtons() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectCurrency = value;
            getData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectCurrency = currenciesList[selectedIndex];

          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    var data = await CoinData().getCoinData('$selectCurrency');
    isWaiting = false;

    setState(() {
      coinValues = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '💰 Crypto Market',
          style: TextStyle(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          currency_container(
              cryptoCurrency: bitCoin,
              value: isWaiting ? '?' : coinValues['BTC'],
              selectCurrency: selectCurrency),
          currency_container(
              cryptoCurrency: etherium,
              value: isWaiting ? '?' : coinValues['ETH'],
              selectCurrency: selectCurrency),
          currency_container(
              cryptoCurrency: lts,
              value: isWaiting ? '?' : coinValues['LTC'],
              selectCurrency: selectCurrency),
          // currency_container(
          //     cryptoCurrency: bnb,
          //     value: coinValues['BNB'],
          //     selectCurrency: selectCurrency),
          // currency_container(
          //     cryptoCurrency: xrp,
          //     value: coinValues['XRP'],
          //     selectCurrency: selectCurrency),
          // currency_container(
          //     cryptoCurrency: dogeCoin,
          //     value: coinValues['DOGE'],
          //     selectCurrency: selectCurrency),
          Container(
            height: 140.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            color: const Color(0xFFf3bb2b),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Platform.isIOS ? iOSPicker() : getAndroidDropDownButtons(),
                // SingleChoice()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// enum Calendar { dollar, euro, rubble, tenge }
//
// class SingleChoice extends StatefulWidget {
//   const SingleChoice({super.key});
//
//   @override
//   State<SingleChoice> createState() => _SingleChoiceState();
// }
//
// class _SingleChoiceState extends State<SingleChoice> {
//   Calendar selectCurrency = Calendar.dollar;
//
//   @override
//   Widget build(BuildContext context) {
//     return SegmentedButton<Calendar>(
//       segments: const <ButtonSegment<Calendar>>[
//         ButtonSegment<Calendar>(
//           value: Calendar.dollar,
//           label: Text(
//             'USD',
//             style: TextStyle(color: Color(0xFFf3bb2b)),
//           ),
//           icon: Icon(
//             FontAwesomeIcons.dollarSign,
//             color: Color(0xFFf3bb2b),
//           ),
//         ),
//         ButtonSegment<Calendar>(
//             value: Calendar.euro,
//             label: Text('EUR', style: TextStyle(color: Color(0xFFf3bb2b))),
//             icon: Icon(FontAwesomeIcons.euroSign, color: Color(0xFFf3bb2b))),
//         ButtonSegment<Calendar>(
//             value: Calendar.rubble,
//             label: Text('RUB', style: TextStyle(color: Color(0xFFf3bb2b))),
//             icon: Icon(FontAwesomeIcons.rubleSign, color: Color(0xFFf3bb2b))),
//         ButtonSegment<Calendar>(
//             value: Calendar.tenge,
//             label: Text('KZT', style: TextStyle(color: Color(0xFFf3bb2b))),
//             icon: Icon(FontAwesomeIcons.tengeSign, color: Color(0xFFf3bb2b))),
//       ],
//       selected: <Calendar>{selectCurrency},
//       onSelectionChanged: (Set<Calendar> newSelection) {
//         setState(() {
//           // By default there is only a single segment that can be
//           // selected at one time, so its value is always the first
//           // item in the selected set.
//           selectCurrency = newSelection.first;
//         });
//       },
//     );
//   }
// }
