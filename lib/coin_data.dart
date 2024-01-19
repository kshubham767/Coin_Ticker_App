import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
String apiKey = dotenv.env['COIN_API_KEY']!;
class CoinData {

  Future getCoinData(String selectedCurrency) async
  {
    Map<String,String> priceMap={};
    for(String crypto in cryptoList) {
      Uri uri = Uri.parse(
          '$coinAPIURL/$crypto/$selectedCurrency/?apiKey=$apiKey');
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        String data = response.body;
        var coinData = jsonDecode(data);
        priceMap[crypto] = coinData['rate'].toStringAsFixed(0);
      }
      else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return priceMap;
  }

}
