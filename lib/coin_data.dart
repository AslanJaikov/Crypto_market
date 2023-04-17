import 'const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinData {
  Future getCoinData(String selectCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(
          Uri.parse('$cryptoMarketUrl/$crypto/$selectCurrency'),
          headers: {'X-CoinAPI-Key': apiKey});
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        print(lastPrice);
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
