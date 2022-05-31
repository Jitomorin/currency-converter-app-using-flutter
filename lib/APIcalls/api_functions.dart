import 'dart:convert';
import 'dart:developer';
import 'package:basic_utils/basic_utils.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class APIFunctions {
  // ignore: non_constant_identifier_names
  final String APIKey = 'TVh9rqImuanSAmjfY35O3ftIQGG7ii0eaHCjrkov';
  final String endpointURL = 'api.freecurrencyapi.com/v1/latest';
  //https://api.freecurrencyapi.com/v1/latest?apikey=TVh9rqImuanSAmjfY35O3ftIQGG7ii0eaHCjrkov&currencies=EUR%2CUSD%2CCAD
  //&currencies=EUR%2CUSD%2CCAD
  fetchCurrency(baseCurrency, String selectedCurrency) async {
    Map<String, String> queryParams = {
      'apikey': APIKey,
      'base_currency': baseCurrency,
      'currencies': selectedCurrency,
    };
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = '$endpointURL?$queryString';
    var response = await http
        .get(Uri.https('api.freecurrencyapi.com', '/v1/latest', queryParams));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      log('response: $data');
      return data;
    } else {
      throw Exception('Failed to load currency');
    }
  }

  fetchCurrencyList(String baseCurrency, String? selectedCurrency) async {
    //https://api.freecurrencyapi.com/v1/latest?apikey=TVh9rqImuanSAmjfY35O3ftIQGG7ii0eaHCjrkov&currencies=&base_currency=AUD
    Map<String, String> queryParams = {
      'apikey': APIKey,
      'base_currency': baseCurrency,
      'currencies': selectedCurrency ?? '',
    };
    String queryString = Uri(queryParameters: queryParams).query;

    /* var requestUrl = '$endpointURL?$queryString'; */
    var response = await http
        .get(Uri.https('api.freecurrencyapi.com', '/v1/latest', queryParams));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      log('response: $data');
      return data;
    } else {
      throw Exception('Failed to load currency list');
    }
  }

  Future<List> fetchLocalCurrencyList() async {
    final String response =
        await rootBundle.loadString('assets/currencies.json');
    final data = await jsonDecode(response)['data'];
    final localCurrencyData = data.keys.toList();
    log('local data: $localCurrencyData');
    return localCurrencyData;
  }
}
